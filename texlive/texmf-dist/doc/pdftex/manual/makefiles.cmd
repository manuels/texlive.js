rem texexec --format=plain pdftex-x
rem copy pdf file to pdftex-y and edit that file
rem texexec --format=plain pdftex-z

texexec --pdf --result=pdftex-a pdftex-t
texexec --pdf --result=pdftex-b pdftex-a --pdfarrange --print=up --paper=A4A3 --addempty=1,2

texexec --pdf --result=pdftex-l pdftex-t --mode=letter
texexec --pdf --result=pdftex-s pdftex-t --mode=screen

del /q pdftex.zip

zip pdftex pdftex-a.pdf pdftex-l.pdf pdftex-s.pdf pdftex-t.tex pdftex-i.tex pdftex-t.txt makefiles.cmd
