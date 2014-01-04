#!/usr/bin/python
###################################################################
# unimap.py
# Generates utf8raw.tex file containing math character definitions
# from modified Unicode character database unimap.txt.
#
# Copyright (C) 2003 David Necas (Yeti)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
###################################################################
# Usage: ./unimap.py
# It takes no arguments, input and output file names are `unimap.txt' and
# `utf8raw.tex' and are hardcoded below (should be fixed once someone finds
# a reason for running it on different files).
#
# The source file unimap.txt is basically Unicode character name list
# http://www.unicode.org/Public/UNIDATA/NamesList.txt
# with additional lines defining TeX expansions of particular characters.
# These lines have format similar to other character info lines, with
# backslash (\) as the line type mark:
# <Tab>\<space>\TeXcontrolsequence
# \TeXcontrolsequence is the control sequence the character should be
# mapped to.
#
# The NamesList.txt file is huge and the number of supported characters is
# still relatively small.  Thus only diff NamesList.txt -> unimap.txt is
# normally distributed (unimap.diff).  Once you have NamesList.txt, you can
# create unimap.txt with following command:
# patch -o unimap.txt NamesList.txt unimap.diff

import re
from time import asctime, gmtime

database = 'unimap.txt'    # Input file
output = 'utf8raw.tex'   # Output file

# Compatibility with Pyhton-2.1
if not __builtins__.__dict__.has_key('True'):
    True = 1; False = 0
if not __builtins__.__dict__.has_key('file'):
    file = open
if not __builtins__.__dict__.has_key('dict'):
    def dict(l):
        d = {}
        for x in l: d[x[0]] = x[1]
        return d

charline_re = re.compile(r'^[0-9A-F]{4,}\t')
comsect_re = re.compile(r'^@+\t')
line_template = '\\mubyte %s %s\\endmubyte %% U+%04X %s\n'

class LineType:
    """NamesList.txt line types. Something between an enum and a hash."""
    Empty = 0
    Comment = '++'
    Section = '@@'
    Character = 'AA'
    IsNot = 'x'
    Alias = '='
    Note = '*'
    Combining = ':'
    Render = '#'
    TeX = '\\'

LineType.map = dict([(val, name) for name, val in LineType.__dict__.items()
                     if name[0].isupper()])

def linetype(line):
    """Determine line type of a NamesList.txt file and extract the text."""
    if not line:
        return LineType.Empty, None
    if line.startswith('@'):
        if line[1:].startswith('@') or line[1:].startswith('+'):
            return LineType.Comment, comsect_re.sub('', line).strip()
        return LineType.Section, comsect_re.sub('', line).strip()
    m = charline_re.match(line)
    if m:
        return LineType.Character, (int(line[:m.end()], 16),
                                    line[m.end():].strip().lower())
    if not line.startswith('\t'):
        raise ValueError, 'Queer line doesn\'t start with @ or Tab'
    line = line.strip()
    if not line:
        return LineType.Empty, None
    if not LineType.map.has_key(line[0]):
        raise ValueError, 'Queer character info line (marker %s)' % line[0]
    return line[0], line[1:].strip()

def utf8chars(u):
    """Format an Unicode character in a \\mubyte-friendly style.

    character ordinal value should be < 0x10000."""
    if u < 0x80:
        return '^^%02x' % u
    if u < 0x800:
        return '^^%02x^^%02x' % (0xc0 | (u >> 6),
                                 0x80 | (0x3f & u))
    return '^^%02x^^%02x^^%02x' % (0xe0 | (u >> 12),
                                   0x80 | (0x3f & (u >> 6)),
                                   0x80 | (0x3f & u))

fh = file(database, 'r')
# skip some initial noise
while True:
    line = fh.readline()
    try:
        typ, val = linetype(line)
    except ValueError:
        continue
    if typ == LineType.Section:
        break

fw = file(output, 'w')
fw.write('%% Generated from %s %s\n' % (database, asctime(gmtime())))
while typ:
    if typ == LineType.Section:
        sect = val
    elif typ == LineType.Character:
        char = val
    elif typ == LineType.TeX:
        if not val.startswith('\\'):
            raise ValueError, '%s is not a control seq (U%X)' % (val, char[0])
        if sect:
            fw.write('\n%% %s\n' % sect)
            sect = None
        fw.write(line_template % (val, utf8chars(char[0]), char[0], char[1]))
    typ, val = linetype(fh.readline())
fh.close()
fw.write('\n\\endinput\n')
fw.close()

