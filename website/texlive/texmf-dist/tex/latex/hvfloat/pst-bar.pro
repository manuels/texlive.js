%!
% PostScript prologue for pst-bar.tex.
% Version 0.2, 2004/08/22
% For distribution, see pstricks.tex.
%
/tx@BarDict 5 dict def tx@BarDict begin
%
% transpose -- Matrix transpose
%
/transpose {
  /X exch def
  /row X length def
  /col X 0 get length def
  [
    /i 0 def
    col {
      [
        /j 0 def
        row {
          X j get i get
          /j j 1 add def
        } repeat
        /i i 1 add def
      ]
    } repeat
  ]
} def
%
end
% END pst-bar.pro
