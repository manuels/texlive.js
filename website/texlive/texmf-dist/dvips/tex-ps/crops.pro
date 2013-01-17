userdict begin
% [PL] Domy/slne parametry       | [E] Default parameters
% Odst/ep linii obci/ecia od     | Cutting distance from the sheet
% arkusza (mm)                   | body (in mm)
/cropmarkdistance 3 def % [0..5]
% Rozmiar paser/ow  (mm)         | Cropmarks size (in mm)
/cropmarksize 10 def
% Rozmiar pask/ow barwnych (mm)  | Color bar size (in mm)
/barsize 5 def
/colorbars 1 def
% 0 - bez paskow barwnych        | 0 - without color steps and bars
%     (np. do monta/zu)          |     (e.g. for plate composition)
% 1 - komplet pask/ow barwnych   | 1 - complete set of color steps and bars
% 2 - tylko ze skalami kolor/ow  | 2 - color steps only
% 3 - tylko z brudzikami         | 3 - color bars only
%
/mirror 0 def
% 0 - normalny widok             | 0 - normal view
% 1 - lustrzane odbicie          | 1 - mirror
%
% opis na marginesie             | marginal label
/marglabel 1 def % 0 -- off, 1 -- on
% dodatkowe przesuni/ecie strony | additional page offset
/xoffset 0 def
/yoffset 0 def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/h_size {hsize} def /v_size {vsize} def 
statusdict /setpageparams known {
   statusdict /orisetpageparams statusdict /setpageparams get put
   statusdict /setpageparams  {4 2 roll CMdim 2 mul add x_offset add 4 1 roll
   CMdim 2 mul add y_offset add 4 1 roll orisetpageparams} put
}{
  statusdict /setpage known {
    statusdict /orisetpage statusdict /setpage get put
    statusdict /setpage  {3 1 roll CMdim 2 mul add x_offset add 3 1 roll
    CMdim 2 mul add y_offset add 3 1 roll orisetpage} put
  } if
} ifelse
%
 /mm{25.4 div 72 mul}def
 /bd{bind def}def
 /_y{exch}def
 /origin{0 0 moveto}def
 /T{translate}def
 /K{setcmykcolor}def
 /box{_y dup 0 rlineto _y 0 _y rlineto neg 0 rlineto closepath}bd
 /_distance {cropmarkdistance mm} def
 /CMdim {cropmarksize mm} def
 /boxdim {barsize mm} def
 /dist{_distance 5 mm le{_distance}{5 mm}ifelse}def
 /x_offset {xoffset mm} def
 /y_offset {yoffset mm} def
 /cmdim{dist neg CMdim add}def
 /cmhalf{cmdim 2 div}def
 /horver{h_size v_size le}def
 /setsep 0 def
%
/rm {
 0 cmhalf moveto cmdim cmhalf lineto stroke
 cmhalf 0 moveto cmhalf cmdim lineto stroke
 cmhalf cmhalf cmdim 3 div 0 360 arc stroke
 } bd
/cm {
 0 CMdim moveto cmdim CMdim lineto stroke
 CMdim 0 moveto CMdim cmdim lineto stroke
 rm} bd
/cmarks{ cm
 h_size CMdim 2 mul add 0 T -1 1 scale cm
 0 v_size CMdim 2 mul add T 1 -1 scale cm
 CMdim 2 mul h_size add 0 T -1 1 scale cm
 } bd
%
/halfmarks{gsave
 0 v_size 2 div CMdim 2 div add dist 2 div add T rm
 h_size cmdim add dist 2 mul add 0 T rm
 h_size 2 div neg cmhalf sub dist sub
 v_size 2 div cmdim 2 div add dist add T rm
 0 v_size neg cmdim sub dist 2 mul sub T rm
 grestore}bd
%
/boxfill{boxdim boxdim box fill}bd
/_step{boxfill horver{0 boxdim}{boxdim 0} ifelse T}bd
/contour{origin
 horver{boxdim boxdim 11 mul}{boxdim 11 mul boxdim} ifelse
 box stroke}bd
/csteps{
 setsep 1 eq {
  gsave 0 .1 1 {origin setgray _step} for grestore
  0 setgray contour % /cbar {0 setgray} bd
  }{
   setsep 0 eq {
   gsave 1 .1 neg 0 {origin 0 _y 0 0 _y 0 _y K _step} for grestore
   1 0 0 0 K contour % /cbar {1 0 0 0 K} bd
   }{ % /cbar {1 setgray} bd
   } ifelse
 } ifelse
 } bd
/cbar {setsep 1 eq {0 setgray}{setsep 0 eq {1 0 0 0 K}{1 setgray
 } ifelse} ifelse} bd
%
/msteps{setsep 2 eq {gsave 0 .1 1 {origin setgray _step} for grestore
  0 setgray contour % /mbar {0 setgray} bd
  }{setsep 0 eq {
   gsave 1 .1 neg 0 {origin 0 _y 0 _y 0 0 _y K _step} for grestore
   0 1 0 0 K contour %/mbar {0 1 0 0 K} bd
   }{ % /mbar {1 setgray} bd
   } ifelse
  } ifelse } bd
/mbar {setsep 2 eq {0 setgray}{setsep 0 eq {0 1 0 0 K}{1 setgray
 } ifelse} ifelse} bd
%
/ysteps{setsep 3 eq {gsave 0 .1 1 {origin setgray _step} for grestore
  0 setgray contour % /ybar {0 setgray} bd
  }{setsep 0 eq {
   gsave 1 .1 neg 0 {origin 0 _y 0 _y 0 _y 0 K _step} for grestore
   0 0 1 0 K contour % /ybar {0 0 1 0 K} bd
   }{ % /ybar {1 setgray} bd
   } ifelse
  } ifelse } bd
/ybar {setsep 3 eq {0 setgray}{setsep 0 eq {0 0 1 0 K}{1 setgray
 } ifelse} ifelse} bd
%
/gsteps{setsep 4 eq {gsave 0 .1 1 {origin setgray _step} for grestore
  0 setgray contour % /gbar {0 setgray} bd
  }{setsep 0 eq {
   gsave 0 .1 1 {origin setgray _step} for grestore
   0 setgray contour % /gbar {0 setgray} bd
   }{ % /gbar {1 setgray} bd
   } ifelse
 } ifelse } bd
/gbar {setsep 4 eq {0 setgray}{setsep 0 eq {0 setgray}{1 setgray
 } ifelse} ifelse} bd
%
/colorsteps{gsave
 horver {CMdim boxdim sub dist sub CMdim boxdim add}
        {CMdim boxdim add CMdim boxdim sub dist sub} ifelse T gsteps
 horver {0 boxdim 12 mul}{boxdim 12 mul 0} ifelse T ysteps
 grestore gsave
 horver {CMdim boxdim sub dist sub v_size CMdim add boxdim 12 mul sub}
        {h_size CMdim add boxdim 12 mul sub CMdim boxdim sub dist sub}
        ifelse T csteps
 horver {0 boxdim 12 mul neg}{boxdim 12 mul neg 0} ifelse T msteps
 grestore} bd
%
/colorbar {gsave
 horver {
  h_size CMdim add dist add CMdim T
  /begbar {boxdim 4 boxdim mul v_size CMdim 2 mul sub} bd
  /endbar {for 0 boxdim T}bd /mt {0 exch moveto} bd
          }{
  CMdim boxdim add v_size CMdim add dist add T
  /begbar {boxdim 4 boxdim mul h_size CMdim 2 mul sub} bd
  /endbar {for boxdim 0 T} bd /mt {exch 0 moveto} bd
          } ifelse
 begbar {mt cbar boxfill} endbar begbar {mt mbar boxfill} endbar
 begbar {mt ybar boxfill} endbar begbar {mt gbar boxfill} endbar
 grestore} bd
%
/color_sep -1 def
/label_s{
  marglabel 1 eq {
   /Helvetica findfont 8 scalefont setfont
   (Page (PS/TeX): ) show page_num_ps 20 string cvs show
   ( / ) show page_num_tex 20 string cvs show
   color_sep 0 ge {
    color_sep 0 eq {(, \ \ Plate CYAN ) show} if
    color_sep 1 eq {(, \ \ Plate MAGENTA ) show} if
    color_sep 2 eq {(, \ \ Plate YELLOW ) show} if
    color_sep 3 eq {(, \ \ Plate BLACK ) show} if
    }{(, \ \ COMPOSITE) show} ifelse
   } if
  } bd
/page_number{gsave
  horver {CMdim 2 mul 10 moveto label_s}
         {10 CMdim 2 mul moveto 90 rotate label_s} ifelse
  grestore} def
%
/_mirror {mirror 1 eq {-1 1 scale h_size neg 0 T} if}bd
%
/full {.1 setlinewidth
 1 colorbars eq {colorsteps colorbar}{
  2 colorbars eq {colorsteps}{
   3 colorbars eq {colorbar}{} ifelse
  } ifelse
 } ifelse
 1 1 1 1 setcmykcolor page_number cmarks halfmarks} bd
%
/save_page_num{pstack 2 copy 1 add
 /page_num_ps exch def /page_num_tex exch def}def
%
[/bop-hook where {pop /bop-hook load aload pop} if
{x_offset y_offset T
 gsave save_page_num full grestore
 CMdim CMdim T _mirror} aload pop] cvx
/bop-hook exch def
end
