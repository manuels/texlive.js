% [PL] Parametry separacji:       [E] Separation parameters:
% Odkomentuj TYLKO JEDNO              Uncomment EXACTLY ONE
% z poni/zszych ustawie/n:            of the following settings:
%%%%%
% /color_sep 0 def % cyan
% /color_sep 1 def % magenta
% /color_sep 2 def % yellow
/color_sep 3 def % black
%%%%%
/ScreenFrequency 150 def
/Cangle 15 def
/Mangle 75 def
/Yangle 0 def
/Kangle 45 def
%
userdict begin /ori_setcmykcolor where {pop} {/ori_setcmykcolor /setcmykcolor
load def} ifelse /ori_setrgbcolor where {pop} {/ori_setrgbcolor /setrgbcolor
load def} ifelse /ori_setgray where {pop} {/ori_setgray /setgray load
def} ifelse /ori_colorimage where {pop} {/ori_colorimage /colorimage
load def} ifelse /ori_image where {pop} {/ori_image /image load def}
ifelse /ori_imagemask where {pop} {/ori_imagemask /imagemask load def}
ifelse /ori_fill where {pop} {/ori_fill /fill load def} ifelse /ori_eofill
where {pop} {/ori_eofill /eofill load def} ifelse /ori_stroke where
{pop} {/ori_stroke /stroke load def} ifelse /ori_show where {pop} {/ori_show
/show load def} ifelse /hax_setcmykcolor /ori_setcmykcolor load def
/maybe_black { 4 copy 1 sub abs epsilon le exch 0 sub abs epsilon le
and exch 0 sub abs epsilon le and exch 0 sub abs epsilon le and /if_delblack
exch def } def /my_fill {userdict begin if_delblack {newpath} {ori_fill}
ifelse end} def /my_eofill {userdict begin if_delblack {newpath} {ori_eofill}
ifelse end} def /my_stroke {userdict begin if_delblack {newpath} {ori_stroke}
ifelse end} def /my_show {userdict begin if_delblack {false charpath
currentpoint newpath moveto} {ori_show} ifelse end} def /eofill {userdict
begin my_eofill end} def /fill {userdict begin my_fill end} def /stroke
{userdict begin my_stroke end} def /show {userdict begin my_show end}
def /setcmykcolor {userdict begin /k_ exch def /y_ exch def /m_ exch
def /c_ exch def c_ m_ y_ k_ hax_setcmykcolor end} def /setgray {ori_setgray
currentcmykcolor setcmykcolor} def /setrgbcolor {ori_setrgbcolor currentcmykcolor
setcmykcolor} def /hax_image { dup type cvlit /dicttype eq { /ImageDict
exch def currentcolorspace dup length 1 eq ImageDict /ImageType get
1 eq and {0 get dup /DeviceRGB eq {/ncomp 3 def} if dup /DeviceGray
eq {/ncomp 1 def} if /DeviceCMYK eq {/ncomp 4 def} if ImageDict /BitsPerComponent
get 8 ne /ncomp 1 ne and {/ncomp 0 def} if } {pop /ncomp 0 def} ifelse
} { false 1 makeimagedict } ifelse ncomp 0 eq {ImageDict ori_image}
{hax_image_} ifelse } def /hax_colorimage { makeimagedict hax_image_
} def /makeimagedict { dup /ncomp exch def dup 4 eq {/DeviceCMYK setcolorspace}
if dup 3 eq {/DeviceRGB setcolorspace} if 1 eq {/DeviceGray setcolorspace}
if /ImageDict 7 dict def ImageDict begin {/MultipleDataSources true
def ncomp array astore} if /DataSource exch def /ImageMatrix exch def
/BitsPerComponent exch def /Height exch def /Width exch def /Decode
[ncomp {0 1} repeat] def /ImageType 1 def end } def /data_str 65532
string def /data_str_ 8192 string def /merge_multi4 { ImageDict /DataSource
get aload pop dup type cvlit /filetype eq { /fdatsrck exch def /fdatsrcy
exch def /fdatsrcm exch def /fdatsrcc exch def /datasrck {fdatsrck
data_str_ readstring pop} def /datasrcy {fdatsrcy data_str_ readstring
pop} def /datasrcm {fdatsrcm data_str_ readstring pop} def /datasrcc
{fdatsrcc data_str_ readstring pop} def } { /datasrck exch def /datasrcy
exch def /datasrcm exch def /datasrcc exch def } ifelse ImageDict /DataSource
{ data_str 0 datasrcc {3 copy put pop 4 add} forall pop 1 datasrcm
{3 copy put pop 4 add} forall pop 2 datasrcy {3 copy put pop 4 add}
forall pop 3 datasrck {3 copy put pop 4 add} forall 3 sub 0 exch getinterval
} put } def /merge_multi3 { ImageDict /DataSource get aload pop dup
type cvlit /filetype eq { /fdatsrcb exch def /fdatsrcg exch def /fdatsrcr
exch def /datasrcb {fdatsrcb data_str_ readstring pop} def /datasrcg
{fdatsrcg data_str_ readstring pop} def /datasrcr {fdatsrcr data_str_
readstring pop} def } { /datasrcb exch def /datasrcg exch def /datasrcr
exch def } ifelse ImageDict /DataSource { data_str 0 datasrcr {3 copy
put pop 3 add} forall pop 1 datasrcg {3 copy put pop 3 add} forall
pop 2 datasrcb {3 copy put pop 3 add} forall 2 sub 0 exch getinterval
} put } def /i_Str 3 string def /O_Str 4 string def /UCR {0.5 mul}
def /BG {0.5 mul} def /min {1 index 1 index le {pop} {exch pop} ifelse}
def /max {1 index 1 index ge {pop} {exch pop} ifelse} def /RGBtoCMYK
{dup 0 get R_scale mul R_shift add /c_i exch def dup 1 get G_scale
mul G_shift add /m_i exch def 2 get B_scale mul B_shift add /y_i exch
def /k_i c_i m_i y_i min min def O_Str dup 0 255 0 c_i k_i UCR sub
cvi max min put dup 1 255 0 m_i k_i UCR sub cvi max min put dup 2 255
0 y_i k_i UCR sub cvi max min put dup 3 255 0 k_i BG cvi max min put
} def /RGBtoCMYKfilter { ImageDict /Decode get aload pop 2 copy sub
/B_scale exch def pop 255 mul 255 exch sub /B_shift exch def 2 copy
sub /G_scale exch def pop 255 mul 255 exch sub /G_shift exch def 2
copy sub /R_scale exch def pop 255 mul 255 exch sub /R_shift exch def
/rtc_file ImageDict /DataSource get def ImageDict /DataSource {rtc_file
i_Str readstring {RGBtoCMYK} if} 0 () /SubFileDecode filter put /DeviceCMYK
setcolorspace /ncomp 4 def ImageDict /Decode [0 1 0 1 0 1 0 1] put
} def /sep_str 8192 string def /SEP_CMYK { 0 hax_sep 4 3 index length
1 sub { 2 index exch get 3 copy put pop 1 add } for dup 0 ne {0 exch
getinterval}{pop pop ()} ifelse } def /SEPfilters { ncomp 4 eq { hax_sep
3 le { /sepproc /SEP_CMYK load def ImageDict begin /Decode [ Decode
hax_sep 2 mul 1 add get Decode hax_sep 2 mul get ] def end } { /sepproc
{dup length 4 idiv 0 exch getinterval} def } ifelse /sep_file ImageDict
/DataSource get def ImageDict /DataSource {sep_file sep_str readstring
pop sepproc} 0 () /SubFileDecode filter put /DeviceGray setcolorspace
} {hax_sep 3 ne {ImageDict /Decode [ 1 1 ] put} if } ifelse hax_sep
4 eq {ImageDict /Decode [ 1 1 ] put} if hax_sep 5 eq {ImageDict /Decode
[ 0 0 ] put} if } def /change_str 12288 string def /CHANGEfilter {
/change_file ImageDict /DataSource get def ImageDict /DataSource {
change_file change_str readstring pop 0 ncomp 2 index length ncomp
sub { 1 index exch 2 copy ncomp getinterval changebits putinterval
} for } 0 () /SubFileDecode filter put } def /hax_image_ { ImageDict
/MultipleDataSources known { ImageDict /MultipleDataSources get { ImageDict
/MultipleDataSources false put ImageDict /DataSource get length dup
4 eq {merge_multi4} if dup 3 eq {merge_multi3} if 1 eq {ImageDict begin
/DataSource DataSource aload pop def end} if } if } if ImageDict begin
/DataSource dup load Width BitsPerComponent mul 7 add 8 idiv Height
ncomp mul mul () /SubFileDecode filter def end to_change_bitmap {CHANGEfilter}
if ncomp 3 eq to_convert_bitmap and {RGBtoCMYKfilter} if ncomp 3 ne
to_sep_bitmap and {SEPfilters} if ImageDict ori_image } def /zero_data_str
65532 string def /hax_imagemask { if_delblack { dup type cvlit /dicttype
eq { /ImageDict exch def } { /ImageDict 7 dict def ImageDict begin
/DataSource exch def /ImageMatrix exch def /Decode exch {[1 0]} {[0
1]} ifelse def /Height exch def /Width exch def /BitsPerComponent 1
def /ImageType 1 def end } ifelse ImageDict begin /DataSource load
Width 7 add 8 idiv Height mul () /SubFileDecode filter end /mask_file
exch def ImageDict /DataSource { zero_data_str 0 mask_file data_str
readstring pop length getinterval } 0 () /SubFileDecode filter put
ImageDict /Decode [1 0] put ImageDict ori_imagemask } {ori_imagemask}
ifelse } def /epsilon 0.005 def /if_delblack false def /to_change_bitmap
false def /to_convert_bitmap false def /to_sep_bitmap false def
currentcmykcolor setcmykcolor end
%
 /dot_spot {dup mul exch dup mul add 1 exch sub 2 div} def 150 0 {dot_spot}
setscreen
%
userdict begin
 color_sep 0 eq
 {/hax_setcmykcolor {maybe_black pop pop pop 1 exch sub ori_setgray} def
  ScreenFrequency Cangle {dot_spot} setscreen}
   {color_sep 1 eq
   {/hax_setcmykcolor {maybe_black pop pop exch pop 1 exch sub ori_setgray} def
    ScreenFrequency Mangle {dot_spot} setscreen}
     {color_sep 2 eq
     {/hax_setcmykcolor {maybe_black pop exch pop exch pop 1 exch sub ori_setgray} def
      ScreenFrequency Yangle {dot_spot} setscreen}
      {/hax_setcmykcolor {exch pop exch pop exch pop 1 exch sub ori_setgray} def
      ScreenFrequency Kangle {dot_spot} setscreen}
      ifelse
   } ifelse
 } ifelse
end
%
userdict begin /image /hax_image load def /colorimage /hax_colorimage
 load def /imagemask /hax_imagemask load def
 /to_sep_bitmap true def /to_convert_bitmap true def
end
currentcmykcolor setcmykcolor
