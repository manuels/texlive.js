#!/bin/bash

################################################################################
#
# Copyright (C) 2011 Silvano Chiaradonna (ISTI-CNR)
#
# Macro: delcmdchanges.bash
#
# License:
#       This program is free software; you can redistribute
#       it and/or modify it under the terms of the
#       GNU General Public License as published by the Free
#       Software Foundation; either version 2 of the License,
#       or (at your option) any later version.
#
#       This program is distributed in the hope that it will
#       be useful, but WITHOUT ANY WARRANTY; without even the
#       implied warranty of MERCHANTABILITY or FITNESS FOR A
#       PARTICULAR PURPOSE. See the GNU General Public
#       License for more details.
#
#       You should have received a copy of the GNU General
#       Public License along with this program; if not,
#       write to the Free Software Foundation, Inc., 59
#       Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#       An on-line copy of the GNU General Public License can
#       be downloaded from the FSF web page at:
#       http://www.gnu.org/copyleft/gpl.html
#
# Version: 1.0
#
# Purpose:
#    This script deletes all changes-commands of the package changes.sty, accepting changes. If option -i is specified you will be prompted to accept or reject changes interactively.
#
# Usage:
#    delcmdchanges.bash [-i] [-h] <inputfile> <outputfile>
#
# Requirements:
#    linux systems
#
################################################################################

usage()
{
    cat << EOF
usage: $0 [options] <inputfile> <outputfile>

This script deletes all changes-commands of the package changes.sty, accepting changes. If option -i is specified you will be prompted to accept or reject changes interactively.

options:
   -h      show this message
   -i      interactive mode
EOF
}

#-----------------------MAIN----------------

while getopts ":ih" opt; do
    case $opt in
    i)
        imode="1"
        shift
        ;;
    h)
        usage
            exit
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        usage
        exit
        ;;
    esac
done

if [ ! -e "$1" ]; then
    echo "Input file not found: $1" >&2
    exit
fi

INFILE="$1"
OUTFILE="$2"

rm -f "${OUTFILE}"
touch "${OUTFILE}"

awk -v im=${imode} -v fn=${OUTFILE} '
# remove commands (accepting changes):
#  \added[<authorid>][<remark>]{<new text>}
#  \deleted[<authorid>][<remark>]{<deleted text>}
#  \replaced[<authorid>][<remark>]{<new text>}{<old text>}

           BEGIN { EOT = SUBSEP }

{ line[NR] = $0 }

END {
    do {
    buf0 = ""
        found = 0
    added = 0
        deleted = 0
        replaced = 0
    while (!found && (c = getc()) != EOT) { # parsing commands
        buf0 = buf0 c
        if( match(buf0, /\\added[[:space:]]*\[[^\]]*\][[:space:]]*\[[^\]]*\][[:space:]]*{/) ||
        match(buf0, /\\added[[:space:]]*\[[^\]]*\][[:space:]]*{/) ||
        match(buf0, /\\added[[:space:]]*{/) ) { # found command \added[<authorid>][<remark>]{<new text>}
        added = 1
                found = 1
        balance = 1
        } else
        if( match(buf0, /\\deleted[[:space:]]*\[[^\]]*\][[:space:]]*\[[^\]]*\][[:space:]]*{/) ||
            match(buf0, /\\deleted[[:space:]]*\[[^\]]*\][[:space:]]*{/) ||
            match(buf0, /\\deleted[[:space:]]*{/) ) { # found command \deleted[<authorid>][<remark>]{<deleted text>}
            deleted = 1
            found = 1
            balance = 1
        } else
            if( match(buf0, /\\replaced[[:space:]]*\[[^\]]*\][[:space:]]*\[[^\]]*\][[:space:]]*{/) ||
            match(buf0, /\\replaced[[:space:]]*\[[^\]]*\][[:space:]]*{/) ||
            match(buf0, /\\replaced[[:space:]]*{/) ) { # found command \replaced[<authorid>][<remark>]{<new text>}{<old text>}
            replaced = 1
            found = 1
                        balance = 1
            }
    }
    if( RLENGTH == -1 ) # command not found
        pbuf0 = buf0
    else { # command found
        pbuf0 = substr(buf0, 1, RSTART-1)
            cmd = substr(buf0, RSTART, RLENGTH) # the command
        }
    printf("%s", pbuf0) >> fn # print text preceding command
    if (c == EOT)
        break
    buf = ""
        if( added ) { # command \added[][]{}
        while (found && balance > 0 && (c = getc()) != EOT) # parsing <new text>
        buf = buf c # <new text>
        cmd = cmd buf # the command
            if ( im ) { # interactive mode
        printf("\nat line: %d\n%s\n", nr,cmd)
        printf("Accept added text, Reject added text, Ignore or Finish accepting changes? [A|r|i|f]")
        getline imoderes < "/dev/tty"
        if( imoderes != "r" && imoderes != "i" ) { # accept added text
            pbuf = substr(buf, 1, length(buf)-1) # remove ending curly brace "}"
            printf("%s", pbuf) >> fn # print <new text>
                    if( imoderes == "f" ) # finish accepting changes
            im = 0 # normal mode
        } else
            if( imoderes == "i" ) # ignore cmd
            printf("%s", cmd) >> fn
            } else { # accept change
        pbuf = substr(buf, 1, length(buf)-1) # remove ending curly brace "}"
        printf("%s", pbuf) >> fn # print <new text>
            }
    } # \added[][]{}
    else
        if( deleted ) { # command \deleted[][]{}
        while (found && balance > 0 && (c = getc()) != EOT) # parsing <deleted text>
            buf = buf c # <deleted text> to skip
        cmd = cmd buf # the command
                if ( im ) { # interactive mode
            printf("\nat line: %d\n%s\n", nr,cmd)
            printf("Accept to remove text, Reject deletion, Ignore or Finish accepting changes? [A|r|i|f]")
            getline imoderes < "/dev/tty"
            if( imoderes == "r" ) { # reject deletion
            pbuf = substr(buf, 1, length(buf)-1) # remove ending curly brace "}"
            printf("%s", pbuf) >> fn # print <deleted text>
            } else
            if( imoderes == "i" ) # ignore cmd
                printf("%s", cmd) >> fn
            else # accept changes
                if( imoderes == "f" ) # finish accepting changes
                im = 0 # normal mode
        } # else accept changes
        } # \deleted[][]{}
        else
        if ( replaced ) { # command \replaced[][]{}{}
            while (replaced && balance > 0 && (c = getc()) != EOT) # parsing <new text>
            buf = buf c # <new text>
            cmd = cmd buf # the command
            pbufnt = substr(buf, 1, length(buf)-1) # new text
            buf = ""
            skip=0
            while ( !skip && (c = getc()) != EOT ) { # skip first curly brace "{"
            buf = buf c
            if ( c !~ /[[:space:]]/ )
                skip = 1
            }
            cmd = cmd buf # the command
            if ( c != "{" ) { # found "{"
            printf("\nOps! Syntax error at line %d of input file: \"%s\"\nPlease fix command \\replaced[][]{}{}: \"{\" is expected.\n\n", nr+1, cmd)
            break
            }
            buf = ""
            balance = 1 # reset balance
            while (replaced && balance > 0 && (c = getc()) != EOT) # parsing <old text>
            buf = buf c # <old text>
                    cmd = cmd buf # the command
                    pbufot = substr(buf, 1, length(buf)) # old text
                    if ( im ) { # interactive mode
            printf("\nat line: %d\n%s\n", nr,cmd)
            printf("Accept change, Reject change, Ignore or Finish accepting changes? [A|r|i|f]")
            getline imoderes < "/dev/tty"
            if( imoderes == "r" ) { # reject change
                printf("%s", pbufot) >> fn # print <old text>
            } else
                if( imoderes == "i" ) { # ignore cmd
                printf("%s", cmd) >> fn
                } else { # accept change
                printf("%s", pbufnt) >> fn # print <new text>
                if( imoderes == "f" ) # finish accepting changes
                    im = 0 # normal mode
                }
            } else { # accept change
            printf("%s", pbufnt) >> fn # print <new text>
            }
        } # \replaced[][]{}{}
    } while(c != EOT)
}

function getc()
{
    if (!nr) {
    nr = 1
    nc = 1
    }

    if (nr > NR)
    return EOT
    if (nc > length(line[nr])) {
    ++nr
    nc = 1
    return "\n"
    }
    c = substr(line[nr], nc, 1)
    ++nc
    if (c == "{")
    ++balance
    else if (c == "}")
    --balance
    if (balance < 0)
    balance = 0
    return c
} '  "${INFILE}" 

