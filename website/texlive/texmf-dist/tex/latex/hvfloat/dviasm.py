#! /usr/bin/env python
# -*- coding: utf_8 -*-
#
# This is DVIasm, a DVI utility for editing DVI files directly.
#
# Copyright (C) 2007-2008 by Jin-Hwan Cho <chofchof@ktug.or.kr>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sys, os.path
from optparse import OptionParser

# Global variables
is_ptex = False
is_subfont = False
cur_font = None
cur_dsize = 0
cur_ssize = 0
subfont_idx = 0
subfont_list = ['cyberb', 'outbtm', 'outbtb', 'outgtm', 'outgtb']

# DVI opcodes
SET_CHAR_0 = 0; SET_CHAR_127 = 127;
SET1 = 128; SET2 = 129; SET3 = 130; SET4 = 131;
SET_RULE = 132;
PUT1 = 133; PUT2 = 134; PUT3 = 135; PUT4 = 136;
PUT_RULE = 137;
NOP = 138;
BOP = 139; EOP = 140;
PUSH = 141; POP = 142;
RIGHT1 = 143; RIGHT2 = 144; RIGHT3 = 145; RIGHT4 = 146;
W0 = 147; W1 = 148; W2 = 149; W3 = 150; W4 = 151;
X0 = 152; X1 = 153; X2 = 154; X3 = 155; X4 = 156;
DOWN1 = 157; DOWN2 = 158; DOWN3 = 159; DOWN4 = 160;
Y0 = 161; Y1 = 162; Y2 = 163; Y3 = 164; Y4 = 165;
Z0 = 166; Z1 = 167; Z2 = 168; Z3 = 169; Z4 = 170;
FNT_NUM_0 = 171; FNT_NUM_63 = 234;
FNT1 = 235; FNT2 = 236; FNT3 = 237; FNT4 = 238;
XXX1 = 239; XXX2 = 240; XXX3 = 241; XXX4 = 242;
FNT_DEF1 = 243; FNT_DEF2 = 244; FNT_DEF3 = 245; FNT_DEF4 = 246;
PRE = 247; POST = 248; POST_POST = 249;
# DVIV opcodes
DIR = 255;
# XDVI opcodes (not supported yet!)
NATIVE_FONT_DEF = 250;
PDF_FILE = 251; PIC_FILE = 252;
GLYPH_ARRAY = 253; GLYPH_STRING = 254;
# DVI identifications
DVI_ID = 2; DVIV_ID = 3; XDVI_ID = 5;

def Warning(msg):
  sys.stderr.write('%s\n' % msg)

def BadDVI(msg):
  raise AttributeError, 'Bad DVI file: %s!' % msg

def GetByte(fp): # { returns the next byte, unsigned }
  try: return ord(fp.read(1))
  except: return -1

def SignedByte(fp): # { returns the next byte, signed }
  try: b = ord(fp.read(1))
  except: return -1
  if b < 128: return b
  else: return b - 256

def Get2Bytes(fp): # { returns the next two bytes, unsigned }
  try: a, b = map(ord, fp.read(2))
  except: BadDVI('Failed to Get2Bytes()')
  return (a << 8) + b

def SignedPair(fp): # {returns the next two bytes, signed }
  try: a, b = map(ord, fp.read(2))
  except: BadDVI('Failed to SignedPair()')
  if a < 128: return (a << 8) + b
  else: return ((a - 256) << 8) + b

def Get3Bytes(fp): # { returns the next three bytes, unsigned }
  try: a, b, c = map(ord, fp.read(3))
  except: BadDVI('Failed to Get3Bytes()')
  return (((a << 8) + b) << 8) + c

def SignedTrio(fp): # { returns the next three bytes, signed }
  try: a, b, c = map(ord, fp.read(3))
  except: BadDVI('Failed to SignedTrio()')
  if a < 128: return (((a << 8) + b) << 8) + c
  else: return ((((a - 256) << 8) + b) << 8) + c

def SignedQuad(fp): # { returns the next four bytes, signed }
  try: a, b, c, d = map(ord, fp.read(4))
  except: BadDVI('Failed to get SignedQuad()')
  if a < 128: return (((((a << 8) + b) << 8) + c) << 8) + d
  else: return ((((((a - 256) << 8) + b) << 8) + c) << 8) + d

def PutByte(q):
  return chr(q & 0xff)

def Put2Bytes(q):
  return PutByte(q>>8) + PutByte(q)

def Put3Bytes(q):
  return PutByte(q>>16) + PutByte(q>>8) + PutByte(q)

def PutSignedQuad(q):
  if q < 0: q += 0x100000000
  return PutByte(q>>24) + PutByte(q>>16) + PutByte(q>>8) + PutByte(q)

def PutUnsigned(q):
  if q >= 0x1000000: return (3, PutSignedQuad(q))
  if q >= 0x10000:   return (2, Put3Bytes(q))
  if q >= 0x100:     return (1, Put2Bytes(q))
  return (0, PutByte(q))

def PutSigned(q):
  if 0 <= q < 0x800000:               return PutUnsigned(q)
  if q < -0x800000 or q >= 0x800000:  return (3, PutSignedQuad(q))
  if q < -0x8000:     q += 0x1000000; return (2, Put3Bytes(q))
  if q < -0x80:       q += 0x10000;   return (1, Put2Bytes(q))
  return (0, PutByte(q))

def GetInt(s):
  try: return int(s)
  except: return -1

def GetStrASCII(s): # used in Parse()
  if len(s) > 1 and ((s[0] == "'" and s[-1] == "'") or (s[0] == '"' and s[-1] == '"')): return [ord(c) for c in s[1:-1].decode('unicode_escape')]
  else: return ''

def UCS2toJIS(c):
  s = c.encode('iso2022-jp')
  if len(s) == 1: return ord(s)
  else:           return (ord(s[3]) << 8) + ord(s[4])

def GetStrUTF8(s): # used in Parse()
  if len(s) > 1 and ((s[0] == "'" and s[-1] == "'") or (s[0] == '"' and s[-1] == '"')):
    t = s[1:-1].decode('string_escape').decode('utf8')
    if is_ptex: return [UCS2toJIS(c) for c in t]
    else:       return [ord(c)       for c in t]
  else:         return ''

def PutStrASCII(t): # unsed in Dump()
  s = ''
  for o in t:
    if o == 92:         s += '\\\\'
    elif 32 <= o < 127: s += chr(o)
    elif o < 256:       s += ('\\x%02x' % o)
    elif o < 65536:     s += ('\\u%04x' % o)
    else:
      Warning('Not support characters > 65535; may skip %d.\n' % o)
  return "'%s'" % s

def PutStrLatin1(t): # unsed in Dump()
  s = ''
  for o in t:
    if o == 92:                           s += '\\\\'
    elif 32 <= o < 127 or 161 <= o < 256: s += chr(o)
    elif o < 256:                         s += ('\\x%02x' % o)
    elif o < 65536:                       s += ('\\u%04x' % o)
    else:
      Warning('Not support characters > 65535; may skip %d.\n' % o)
  return "'%s'" % s

def PutStrUTF8(t): # unsed in Dump()
  s = ''
  if is_subfont:
    for o in t:
      s += unichr((subfont_idx << 8) + o).encode('utf8')
  else: # not the case of subfont
    for o in t:
      if o == 92:         s += '\\\\'
      elif 32 <= o < 127: s += chr(o)
      elif o < 128:       s += ('\\x%02x' % o)
      elif is_ptex:
        s += ''.join(['\x1b$B', chr(o/256), chr(o%256)]).decode('iso2022-jp').encode('utf8')
      else:               s += unichr(o).encode('utf8')
  return "'%s'" % s

def PutStrSJIS(t): # unsed in Dump()
  s = ''
  for o in t:
    if o == 92:         s += '\\\\'
    elif 32 <= o < 127: s += chr(o)
    elif o < 128:       s += ('\\x%02x' % o)
    else:
      s += ''.join(['\x1b$B', chr(o/256), chr(o%256)]).decode('iso2022-jp').encode('sjis')
  return "'%s'" % s

def IsFontChanged(f, z):
  global cur_font, cur_ssize, subfont_idx, is_subfont
  for n in subfont_list:
    if n == f[:-2]:
      is_subfont = True
      subfont_idx = int(f[-2:], 16)
      if cur_font == n and cur_ssize == z:
        return False
      else:
        cur_font = n; cur_ssize = z
        return True
  else:
    is_subfont = False
    cur_font = f; cur_ssize = z
    return True

############################################################
# DVI class
############################################################
class DVI(object):
  def __init__(self, unit='pt'):
    if   unit == 'sp': self.byconv = self.by_sp_conv
    elif unit == 'bp': self.byconv = self.by_bp_conv
    elif unit == 'mm': self.byconv = self.by_mm_conv
    elif unit == 'cm': self.byconv = self.by_cm_conv
    elif unit == 'in': self.byconv = self.by_in_conv
    else:              self.byconv = self.by_pt_conv
    self.Initialize()

  ##########################################################
  # Initialize: Required by __init__(), Load(), and Parse()
  ##########################################################
  def Initialize(self):
    self.id = DVI_ID
    self.numerator   = 25400000
    self.denominator = 473628672
    self.mag = 1000
    self.ComputeConversionFactors()
    self.comment = ''
    self.font_def = {}
    self.max_v = self.max_h = self.max_s = self.total_pages = 0
    self.pages = []

  ##########################################################
  # Load: DVI -> Internal Format
  ##########################################################
  def Load(self, fn):
    fp = file(fn, 'rb')
    self.LoadFromFile(fp)
    fp.close()

  def LoadFromFile(self, fp):
    self.Initialize()
    fp.seek(0, 2)
    if fp.tell() < 53: BadDVI('less than 53 bytes long')
    self.ProcessPreamble(fp)
    self.ProcessPostamble(fp)
    loc = self.first_backpointer
    while loc >= 0:
      fp.seek(loc)
      if GetByte(fp) != BOP: BadDVI('byte %d is not bop' % fp.tell())
      cnt = [SignedQuad(fp) for i in xrange(10)]
      loc = SignedQuad(fp)
      page = self.ProcessPage(fp)
      self.pages.insert(0, {'count':cnt, 'content':page})

  def ProcessPreamble(self, fp):
    fp.seek(0)
    if GetByte(fp) != PRE: BadDVI("First byte isn't start of preamble")
    id = GetByte(fp)
    if id != DVI_ID and id != DVIV_ID and id != XDVI_ID:
      Warning("ID byte is %d; use the default %d!" % (id, DVI_ID))
    else:
      self.id = id
    numerator = SignedQuad(fp)
    if numerator <= 0:
      Warning('numerator is %d; use the default 25400000!' % numerator)
    else:
      self.numerator = numerator
    denominator = SignedQuad(fp)
    if denominator <= 0:
      Warning('denominator is %d; use the default 473628672!' % denominator)
    else:
      self.denominator = denominator
    mag = SignedQuad(fp)
    if mag <= 0:
      Warning('magnification is %d; use the default 1000!' % mag)
    else:
      self.mag = mag
    self.comment = fp.read(GetByte(fp))
    self.ComputeConversionFactors()

  def ProcessPostamble(self, fp):
    fp.seek(-5, 2) # at least four 223's
    while True:
      k = GetByte(fp)
      if   k < 0:    BadDVI('all 223s; is it a DVI file?') # found EOF
      elif k != 223: break
      fp.seek(-2, 1)
    if k != DVI_ID and k != DVIV_ID and k != XDVI_ID:
      Warning('ID byte is %d' % k)
    fp.seek(-5, 1)
    q = SignedQuad(fp)
    m = fp.tell() # id_byte
    if q < 0 or q > m - 33: BadDVI('post pointer %d at byte %d' % (q, m - 4))
    fp.seek(q) # move to post
    k = GetByte(fp)
    if k != POST: BadDVI('byte %d is not post' % k)
    self.post_loc = q
    self.first_backpointer = SignedQuad(fp)

    if SignedQuad(fp) != self.numerator:
      Warning("numerator doesn't match the preamble!")
    if SignedQuad(fp) != self.denominator:
      Warning("denominator doesn't match the preamble!")
    if SignedQuad(fp) != self.mag:
      Warning("magnification doesn't match the preamble!")
    self.max_v = SignedQuad(fp)
    self.max_h = SignedQuad(fp)
    self.max_s = Get2Bytes(fp)
    self.total_pages = Get2Bytes(fp)
    while True:
      k = GetByte(fp)
      if   k == FNT_DEF1: p = GetByte(fp)
      elif k == FNT_DEF2: p = Get2Bytes(fp)
      elif k == FNT_DEF3: p = Get3Bytes(fp)
      elif k == FNT_DEF4: p = SignedQuad(fp)
      elif k != NOP: break
      self.DefineFont(p, fp)
    if k != POST_POST:
      Warning('byte %d is not postpost!' % (fp.tell() - 1))
    if SignedQuad(fp) != self.post_loc:
      Warning('bad postamble pointer in byte %d!' % (fp.tell() - 4))
    m = GetByte(fp)
    if m != DVI_ID and m != DVIV_ID and m != XDVI_ID:
      Warning('identification in byte %d should be %d, %d, or %d!' % (fp.tell() - 1, DVI_ID, DVIV_ID, XDVI_ID))

  def DefineFont(self, e, fp):
    c = SignedQuad(fp) # font_check_sum
    q = SignedQuad(fp) # font_scaled_size
    d = SignedQuad(fp) # font_design_size
    n = fp.read(GetByte(fp) + GetByte(fp))
    try:
      f = self.font_def[e]
    except KeyError:
      self.font_def[e] = {'name':n, 'checksum':c, 'scaled_size':q, 'design_size':d}
      if q <= 0 or q >= 01000000000:
        Warning("%s---not loaded, bad scale (%d)!" % (n, q))
      elif d <= 0 or d >= 01000000000:
        msssage("%s---not loaded, bad design size (%d)!" % (n, d))
    else:
      if f['checksum'] != c:
        Warning("\t---check sum doesn't match previous definition!")
      if f['scaled_size'] != q:
        Warning("\t---scaled size doesn't match previous definition!")
      if f['design_size'] != d:
        Warning("\t---design size doesn't match previous definition!")
      if f['name'] != n:
        Warning("\t---font name doesn't match previous definition!")

  def ProcessPage(self, fp):
    s = []
    while True:
      o = GetByte(fp)
      p = self.Get1Arg(o, fp)
      if o < SET_CHAR_0 + 128 or o in (SET1, SET2, SET3, SET4):
        q = [p]
        while True:
          o = GetByte(fp)
          p = self.Get1Arg(o, fp)
          if o < SET_CHAR_0 + 128 or o in (SET1, SET2, SET3, SET4):
            q.append(p)
          else:
            break
        s.append([SET1, q])
      if o == SET_RULE:
        s.append([SET_RULE, [p, SignedQuad(fp)]])
      elif o in (PUT1, PUT2, PUT3, PUT4):
        s.append([PUT1, p])
      elif o == PUT_RULE:
        s.append([PUT_RULE, [p, SignedQuad(fp)]])
      elif o == NOP:
        continue
      elif o == BOP:
        Warning('bop occurred before eop!')
        break
      elif o == EOP:
        break
      elif o == PUSH:
        s.append([PUSH])
      elif o == POP:
        s.append([POP])
      elif o in (RIGHT1, RIGHT2, RIGHT3, RIGHT4):
        s.append([RIGHT1, p])
      elif o == W0:
        s.append([W0])
      elif o in (W1, W2, W3, W4):
        s.append([W1, p])
      elif o == X0:
        s.append([X0])
      elif o in (X1, X2, X3, X4):
        s.append([X1, p])
      elif o in (DOWN1, DOWN2, DOWN3, DOWN4):
        s.append([DOWN1, p])
      elif o == Y0:
        s.append([Y0])
      elif o in (Y1, Y2, Y3, Y4):
        s.append([Y1, p])
      elif o == Z0:
        s.append([Z0])
      elif o in (Z1, Z2, Z3, Z4):
        s.append([Z1, p])
      elif o < FNT_NUM_0 + 64 or o in (FNT1, FNT2, FNT3, FNT4):
        s.append([FNT1, p])
      elif o in (XXX1, XXX2, XXX3, XXX4):
        q = fp.read(p)
        s.append([XXX1, q])
      elif o in (FNT_DEF1, FNT_DEF2, FNT_DEF3, FNT_DEF4):
        self.DefineFont(p, fp)
      elif o == DIR:
        s.append([DIR, p])
      elif o == PRE:
        Warning('preamble command within a page!')
        break
      elif o in (POST, POST_POST):
        Warning('postamble command %d!' % o)
        break
      else:
        Warning('undefined command %d!' % o)
        break
    return s

  def Get1Arg(self, o, fp):
    if o < SET_CHAR_0 + 128:
      return o - SET_CHAR_0
    if o in (SET1, PUT1, FNT1, XXX1, FNT_DEF1, DIR):
      return GetByte(fp)
    if o in (SET2, PUT2, FNT2, XXX2, FNT_DEF2):
      return Get2Bytes(fp)
    if o in (SET3, PUT3, FNT3, XXX3, FNT_DEF3):
      return Get3Bytes(fp)
    if o in (RIGHT1, W1, X1, DOWN1, Y1, Z1):
      return SignedByte(fp)
    if o in (RIGHT2, W2, X2, DOWN2, Y2, Z2):
      return SignedPair(fp)
    if o in (RIGHT3, W3, X3, DOWN3, Y3, Z3):
      return SignedTrio(fp)
    if o in (SET4, SET_RULE, PUT4, PUT_RULE, RIGHT4, W4, X4, DOWN4, Y4, Z4, FNT4, XXX4, FNT_DEF4):
      return SignedQuad(fp)
    if o in (NOP, BOP, EOP, PUSH, POP, PRE, POST, POST_POST) or o > POST_POST:
      return 0
    if o in (W0, X0, Y0, Z0):
      return 0
    if o < FNT_NUM_0 + 64:
      return o - FNT_NUM_0

  ##########################################################
  # Save: Internal Format -> DVI
  ##########################################################
  def Save(self, fn):
    fp = file(fn, 'wb')
    self.SaveToFile(fp)
    fp.close()

  def SaveToFile(self, fp):
    # WritePreamble
    fp.write(''.join([chr(PRE), PutByte(self.id), PutSignedQuad(self.numerator), PutSignedQuad(self.denominator), PutSignedQuad(self.mag), PutByte(len(self.comment)), self.comment]))
    # WriteFontDefinitions
    self.WriteFontDefinitions(fp)
    # WritePages
    stackdepth = 0; loc = -1
    for page in self.pages:
      w = x = y = z = 0; stack = []
      s = [chr(BOP)]
      s.extend([PutSignedQuad(c) for c in page['count']])
      s.append(PutSignedQuad(loc))
      for cmd in page['content']:
        if cmd[0] == SET1:
          for o in cmd[1]:
            if o < 128: s.append(chr(SET_CHAR_0 + o))
            else:       s.append(self.CmdPair([SET1, o]))
        elif cmd[0] in (SET_RULE, PUT_RULE):
          s.append(chr(cmd[0]) + PutSignedQuad(cmd[1][0]) + PutSignedQuad(cmd[1][1]))
        elif cmd[0] == PUT1:
          s.append(self.CmdPair([PUT1, cmd[1][0]]))
        elif cmd[0] in (RIGHT1, DOWN1):
          s.append(self.CmdPair(cmd))
        elif cmd[0] in (W0, X0, Y0, Z0):
          s.append(chr(cmd[0]))
        elif cmd[0] == PUSH:
          s.append(chr(PUSH))
          stack.append((w, x, y, z))
          if len(stack) > stackdepth: stackdepth = len(stack)
        elif cmd[0] == POP:
          s.append(chr(POP))
          w, x, y, z = stack.pop()
        elif cmd[0] == W1:
          w = cmd[1]; s.append(self.CmdPair(cmd))
        elif cmd[0] == X1:
          x = cmd[1]; s.append(self.CmdPair(cmd))
        elif cmd[0] == Y1:
          y = cmd[1]; s.append(self.CmdPair(cmd))
        elif cmd[0] == Z1:
          z = cmd[1]; s.append(self.CmdPair(cmd))
        elif cmd[0] == FNT1:
          if cmd[1] < 64: s.append(chr(FNT_NUM_0 + cmd[1]))
          else:           s.append(self.CmdPair(cmd))
        elif cmd[0] == XXX1:
          l = len(cmd[1])
          if l < 256: s.append(chr(XXX1) + chr(l) + cmd[1])
          else:       s.append(chr(XXX4) + PutSignedQuad(l) + cmd[1])
        elif cmd[0] == DIR:
          s.append(chr(DIR) + chr(cmd[1]))
        else:
          Warning('invalid command %s!' % cmd[0])
      s.append(chr(EOP))
      loc = fp.tell()
      fp.write(''.join(s))
    # WritePostamble
    post_loc = fp.tell()
    fp.write(''.join([chr(POST), PutSignedQuad(loc), PutSignedQuad(self.numerator), PutSignedQuad(self.denominator), PutSignedQuad(self.mag), PutSignedQuad(self.max_v), PutSignedQuad(self.max_h), Put2Bytes(stackdepth+1), Put2Bytes(len(self.pages))]))
    # WriteFontDefinitions
    self.WriteFontDefinitions(fp)
    # WritePostPostamble
    fp.write(''.join([chr(POST_POST), PutSignedQuad(post_loc), PutByte(self.id), '\xdf\xdf\xdf\xdf']))
    loc = fp.tell()
    while (loc % 4) != 0:
      fp.write('\xdf'); loc += 1

  def WriteFontDefinitions(self, fp):
    s = []
    for e in sorted(self.font_def.keys()):
      l, q = PutUnsigned(e)
      s.append(PutByte(FNT_DEF1 + l))
      s.append(q)
      s.append(PutSignedQuad(self.font_def[e]['checksum']))
      s.append(PutSignedQuad(self.font_def[e]['scaled_size']))
      s.append(PutSignedQuad(self.font_def[e]['design_size']))
      s.append('\x00')
      s.append(PutByte(len(self.font_def[e]['name'])))
      s.append(self.font_def[e]['name'])
    fp.write(''.join(s))

  def CmdPair(self, cmd):
    l, q = PutSigned(cmd[1])
    return chr(cmd[0] + l) + q

  ##########################################################
  # Parse: Text -> Internal Format
  ##########################################################
  def Parse(self, fn, encoding=''):
    fp = file(fn, 'r')
    s = fp.read()
    fp.close()
    self.ParseFromString(s, encoding=encoding)

  def ParseFromString(self, s, encoding=''):
    global GetStr, cur_font, cur_dsize, cur_ssize, subfont_idx
    if encoding == 'ascii': GetStr = GetStrASCII
    else:                   GetStr = GetStrUTF8
    self.Initialize()
    self.fnt_num = 0
    for l in s.split('\n'):
      l = l.strip()
      if not l or l[0] == '%': continue
      try:
        key, val = l.split(':', 1)
        key = key.strip(); val = val.strip()
      except:
        if l[-1] == ']': v = l[:-1].split(' ')
        else: v = l.split(' ')
        if v[0] == "[page":
          self.cur_page = []
          count = [GetInt(c) for c in v[1:]]
          if len(count) < 10: count += ([0] * (10-len(count)))
          self.pages.append({'count':count, 'content':self.cur_page})
        continue
      # ParsePreamble
      if key == "id":
        self.id = GetInt(val)
        if self.id != DVI_ID and self.id != DVIV_ID and self.id != XDVI_ID:
          Warning("identification byte should be %d, %d, or %d!" % (DVI_ID, DVIV_ID, XDVI_ID))
      elif key == "numerator":
        d = GetInt(val)
        if d <= 0:
          Warning('non-positive numerator %d!' % d)
        else:
          self.numerator = d
          self.ComputeConversionFactors()
      elif key == "denominator":
        d = GetInt(val)
        if d <= 0:
          Warning('non-positive denominator %d!' % d)
        else:
          self.denominator = d
          self.ComputeConversionFactors()
      elif key == "magnification":
        d = GetInt(val)
        if d <= 0:
          Warning('non-positive magnification %d!' % d)
        else:
          self.mag = d
      elif key == "comment":
        self.comment = val[1:-1]
      # Parse Postamble
      elif key == "maxv":
        self.max_v = self.ConvLen(val)
      elif key == "maxh":
        self.max_h = self.ConvLen(val)
      elif key == "maxs":
        self.max_s = GetInt(val)
      elif key == "pages":
        self.total_pages = GetInt(val)
      # Parse Font Definitions
      elif key == "fntdef":
        n, q, d = self.GetFntDef(val)
        self.font_def[self.fnt_num] = {'name':n, 'design_size':d, 'scaled_size':q, 'checksum':0}
        self.fnt_num += 1
      # Parse Pages
      elif key == 'xxx':
        self.cur_page.append([XXX1, eval(val)])
      elif key == 'set':
        ol = GetStr(val)
        if is_subfont:
          subfont_idx = (ol[0] >> 8)
          self.AppendFNT1()
          nl = [ol[0] & 0xff]
          for o in ol[1:]:
            idx = (o >> 8)
            if idx != subfont_idx:
              self.cur_page.append([SET1, nl])
              subfont_idx = idx
              self.AppendFNT1()
              nl = [o & 0xff]
            else:
              nl.append(o & 0xff)
          self.cur_page.append([SET1, nl])
        else:
          self.cur_page.append([SET1, ol])
      elif key == 'put':
        self.cur_page.append([PUT1, GetStr(val)])
      elif key == 'setrule':
        v = val.split(' ')
        if len(v) != 2:
          Warning('two values are required for setrule!')
          continue
        self.cur_page.append([SET_RULE, [self.ConvLen(c) for c in v]])
      elif key == 'putrule':
        v = val.split(' ')
        if len(v) != 2:
          Warning('two values are required for putrule!')
          continue
        self.cur_page.append([PUT_RULE, [self.ConvLen(c) for c in v]])
      elif key == 'fnt':
        n, q, d = self.GetFntDef(val)
        if n in subfont_list:
          is_subfont = True
          cur_font = n; cur_dsize = d; cur_ssize = q
        else:
          is_subfont = False
          f = {'name':n, 'design_size':d, 'scaled_size':q, 'checksum':0}
          try:
            e = self.font_def.keys()[self.font_def.values().index(f)]
          except:
            e = self.fnt_num
            self.font_def[self.fnt_num] = f
            self.fnt_num += 1
          self.cur_page.append([FNT1, e])
      elif key == 'right':
        self.cur_page.append([RIGHT1, self.ConvLen(val)])
      elif key == 'down':
        self.cur_page.append([DOWN1, self.ConvLen(val)])
      elif key == 'w':
        self.cur_page.append([W1, self.ConvLen(val)])
      elif key == 'x':
        self.cur_page.append([X1, self.ConvLen(val)])
      elif key == 'y':
        self.cur_page.append([Y1, self.ConvLen(val)])
      elif key == 'z':
        self.cur_page.append([Z1, self.ConvLen(val)])
      elif key == 'push':
        self.cur_page.append([PUSH])
      elif key == 'pop':
        self.cur_page.append([POP])
      elif key == 'w0':
        self.cur_page.append([W0])
      elif key == 'x0':
        self.cur_page.append([X0])
      elif key == 'y0':
        self.cur_page.append([Y0])
      elif key == 'z0':
        self.cur_page.append([Z0])
      elif key == 'dir':
        self.cur_page.append([DIR, GetInt(val)])
      else:
        Warning('invalid command %s!' % key)

  def AppendFNT1(self):
    f = {'name':cur_font+"%02x"%subfont_idx, 'design_size':cur_dsize, 'scaled_size':cur_ssize, 'checksum':0}
    try:
      e = self.font_def.keys()[self.font_def.values().index(f)]
    except:
      e = self.fnt_num
      self.font_def[e] = f
      self.fnt_num += 1
    self.cur_page.append([FNT1, e])

  ##########################################################
  # Dump: Internal Format -> Text
  ##########################################################
  def Dump(self, fn, tabsize=2, encoding=''):
    fp = file(fn, 'w')
    self.DumpToFile(fp, tabsize=tabsize, encoding=encoding)
    fp.close()

  def DumpToFile(self, fp, tabsize=2, encoding=''):
    global PutStr
    if   encoding == 'ascii':  PutStr = PutStrASCII
    elif encoding == 'latin1': PutStr = PutStrLatin1
    elif encoding == 'sjis':   PutStr = PutStrSJIS
    else:                      PutStr = PutStrUTF8
    # DumpPreamble
    fp.write("[preamble]\n")
    fp.write("id: %d\n" % self.id)
    fp.write("numerator: %d\n" % self.numerator)
    fp.write("denominator: %d\n" % self.denominator)
    fp.write("magnification: %d\n" % self.mag)
    fp.write("comment: %s\n" % repr(self.comment))
    # DumpPostamble
    fp.write("\n[postamble]\n")
    fp.write("maxv: %s\n" % self.byconv(self.max_v))
    fp.write("maxh: %s\n" % self.byconv(self.max_h))
    fp.write("maxs: %d\n" % self.max_s)
    fp.write("pages: %d\n" % self.total_pages)
    # DumpFontDefinitions
    fp.write("\n[font definitions]\n")
    for e in sorted(self.font_def.keys()):
      fp.write("fntdef: %s " % self.font_def[e]['name'])
      if self.font_def[e]['design_size'] != self.font_def[e]['scaled_size']:
        fp.write("(%s) " % self.by_pt_conv(self.font_def[e]['design_size']))
      fp.write("at %s\n" % self.by_pt_conv(self.font_def[e]['scaled_size']))
    # DumpPages
    for page in self.pages:
      fp.write("\n[page" + (" %d"*10 % tuple(page['count'])) + "]\n")
      indent = 0
      for cmd in page['content']:
        if cmd[0] == POP:
          indent -= tabsize
          fp.write("%spop:\n" % (' ' * indent))
          continue
        fp.write("%s" % (' ' * indent))
        if cmd[0] == PUSH:
          fp.write("push:\n")
          indent += tabsize
        elif cmd[0] == XXX1:
          fp.write("xxx: %s\n" % repr(cmd[1]))
        elif cmd[0] == DIR:
          fp.write("dir: %d\n" % cmd[1])
        elif cmd[0] == SET_RULE:
          fp.write("setrule: %s %s\n" % (self.byconv(cmd[1][0]), self.byconv(cmd[1][1])))
        elif cmd[0] == PUT_RULE:
          fp.write("putrule: %s %s\n" % (self.byconv(cmd[1][0]), self.byconv(cmd[1][1])))
        elif cmd[0] == SET1:
          fp.write("set: %s\n" % PutStr(cmd[1]))
        elif cmd[0] == PUT1:
          fp.write("put: %s\n" % PutStr(cmd[1]))
        elif cmd[0] == FNT1:
          f = self.font_def[cmd[1]]['name']
          z = self.font_def[cmd[1]]['scaled_size']
          if IsFontChanged(f, z):
            fp.write("fnt: %s " % cur_font)
            if self.font_def[cmd[1]]['design_size'] != self.font_def[cmd[1]]['scaled_size']:
              fp.write("(%s) " % self.by_pt_conv(self.font_def[cmd[1]]['design_size']))
            fp.write("at %s\n" % self.by_pt_conv(cur_ssize))
        elif cmd[0] == RIGHT1:
          fp.write("right: %s\n" % self.byconv(cmd[1]))
        elif cmd[0] == DOWN1:
          fp.write("down: %s\n" % self.byconv(cmd[1]))
        elif cmd[0] == W1:
          fp.write("w: %s\n" % self.byconv(cmd[1]))
        elif cmd[0] == X1:
          fp.write("x: %s\n" % self.byconv(cmd[1]))
        elif cmd[0] == Y1:
          fp.write("y: %s\n" % self.byconv(cmd[1]))
        elif cmd[0] == Z1:
          fp.write("z: %s\n" % self.byconv(cmd[1]))
        elif cmd[0] == W0:
          fp.write("w0:\n")
        elif cmd[0] == X0:
          fp.write("x0:\n")
        elif cmd[0] == Y0:
          fp.write("y0:\n")
        elif cmd[0] == Z0:
          fp.write("z0:\n")

  ##########################################################
  # Misc Functions
  ##########################################################
  def ComputeConversionFactors(self):
    self.sp_conv = (self.numerator / 25400000.) * (473628672. / self.denominator)
    self.pt_conv = (self.numerator / 25400000.) * (7227. / self.denominator)
    self.bp_conv = (self.numerator / 254000.) * (72. / self.denominator)
    self.mm_conv = (self.numerator / 10000.) / self.denominator
    self.cm_conv = (self.numerator / 100000.) / self.denominator
    self.in_conv = (self.numerator / 254000.) * (1. / self.denominator)

  def ConvLen(self, s):
    try:    return int(s)
    except: pass
    try:    f = float(s[:-2])
    except: return 0
    m = s[-2:]
    if   m == "pt": return int(round(f / self.pt_conv))
    elif m == "in": return int(round(f / self.in_conv))
    elif m == "mm": return int(round(f / self.mm_conv))
    elif m == "cm": return int(round(f / self.cm_conv))
    elif m == "bp": return int(round(f / self.bp_conv))
    elif m == "sp": return int(round(f / self.sp_conv))
    else:
      try:    return int(round(f / self.pt_conv))
      except: return 0

  def GetFntDef(self, s):
    try:
      n, size = s.split('(', 1)
      d, q = size.split(')', 1)
    except:
      n, q = s.split(' ', 1)
    n = n.strip(); q = q.strip()
    if q[:2] == "at": q = q[2:]
    q = self.ConvLen(q.strip())
    try:    d = self.ConvLen(d.strip())
    except: d = q
    return n, q, d

  def by_sp_conv(self, a):
    v = self.sp_conv * a
    return "%dsp" % int(v)

  def by_pt_conv(self, a):
    v = self.pt_conv * a
    if v == int(v): return "%dpt" % int(v)
    else:           return "%fpt" % v

  def by_bp_conv(self, a):
    v = self.bp_conv * a
    if v == int(v): return "%dbp" % int(v)
    else:           return "%fbp" % v

  def by_mm_conv(self, a):
    v = self.mm_conv * a
    if v == int(v): return "%dmm" % int(v)
    else:           return "%fmm" % v

  def by_cm_conv(self, a):
    v = self.cm_conv * a
    if v == int(v): return "%dcm" % int(v)
    else:           return "%fcm" % v

  def by_in_conv(self, a):
    v = self.in_conv * a
    if v == int(v): return "%din" % int(v)
    else:           return "%fin" % v

############################################################
# Misc Functions for Main Routine
############################################################
def ProcessOptions():
  usage = """%prog [options] dvi_file|dvi_dump_file

DVIasm is a Python script to support changing or creating DVI files
via disassembling into text, editing, and then reassembling into
binary format. It is fully documented at

http://tug.org/TUGboat/Articles/tb28-2/tb89cho.pdf 
http://ajt.ktug.kr/assets/2008/5/1/0201cho.pdf"""

  version = """This is %prog-20080520 by Jin-Hwan Cho (Korean TeX Society)
  
Copyright (C) 2007-2008 by Jin-Hwan Cho <chofchof@ktug.or.kr>

This is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version."""

  parser = OptionParser(usage=usage, version=version)
  parser.add_option("-u", "--unit",
                    action="store", type="string", dest="unit",
                    metavar="STR",
                    help="unit (sp, pt, bp, mm, cm, in) [default=%default]")
  parser.add_option("-o", "--output",
                    action="store", type="string", dest="output",
                    metavar="FILE",
                    help="filename for output instead of stdout")
  parser.add_option("-e", "--encoding",
                    action="store", type="string", dest="encoding",
                    metavar="STR",
                    help="encoding for input/output [default=%default]")
  parser.add_option("-t", "--tabsize",
                    action="store", type="int", dest="tabsize",
                    metavar="INT",
                    help="tab size for push/pop [default=%default]")
  parser.add_option("-p", "--ptex",
                    action="store_true", dest="ptex", default=False,
                    help="extended DVI for Japanese pTeX")
  parser.add_option("-s", "--subfont",
                    action="append", type="string", dest="subfont",
                    metavar="STR",
                    help="the list of fonts with UCS2 subfont scheme (comma separated); disable internal subfont list if STR is empty")
  parser.set_defaults(unit='pt', encoding='utf8', tabsize=2)
  (options, args) = parser.parse_args()
  if not options.unit in ['sp', 'pt', 'bp', 'mm', 'cm', 'in']:
    parser.error("invalid unit name '%s'!" % options.unit)
  if options.tabsize < 0: 
    parser.error("negative tabsize!")
  if not options.encoding in ['ascii', 'latin1', 'utf8', 'sjis']:
    parser.error("invalid encoding '%s'!" % options.encoding)
  if options.ptex:
    global is_ptex
    is_ptex = True
    if not options.encoding in ['utf8', 'sjis']:
      parser.error("invalid encoding '%s' for Japanese pTeX!" % options.encoding)
  if options.subfont:
    global subfont_list
    if not options.subfont[0]: # disable subfont
      subfont_list = []
    for l in options.subfont:
      subfont_list.extend([f.strip() for f in l.split(',')])
  if len(args) != 1:
    parser.error("try with the option --help!")
  return (options, args)

def IsDVI(fname):
  from os.path import splitext
  if splitext(fname)[1] != '.dvi': return False
  try:
    fp = file(fname, 'rb')
    fp.seek(0)
    if GetByte(fp) != PRE: return False
    fp.seek(-4, 2)
    if GetByte(fp) != 223: return False
    fp.close()
  except:
    sys.stderr.write('Failed to read %s\n' % fname)
    return False
  return True

############################################################
# Main Routine
############################################################
if __name__ == '__main__':
  (options, args) = ProcessOptions()
  aDVI = DVI(unit=options.unit)
  if IsDVI(args[0]): # dvi -> dump
    aDVI.Load(args[0])
    if options.output: aDVI.Dump(options.output, tabsize=options.tabsize, encoding=options.encoding)
    else:              aDVI.DumpToFile(sys.stdout, tabsize=options.tabsize, encoding=options.encoding)
  else: # dump -> dvi
    aDVI.Parse(args[0], encoding=options.encoding)
    if options.output: aDVI.Save(options.output)
    else:              aDVI.SaveToFile(sys.stdout)
