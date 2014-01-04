%% iso8859-2

                  TeX Live zaprasza

TeX Live oferuje pe³ny system TeX dla wielu odmian systemu Unix, MacOSX 
i Windows (w wersji 32-bitowej). Znajduj± siê tu programy do sk³adu 
tekstów, programy do przegl±dania i drukowania dokumentów TeX-owych 
w wielu jêzykach oraz bogate kolekcje makr i fontów. 

W dystrybucji TeX Live znalaz³y siê dokumentacje dotycz±ce ogólnie TeX-a, a tak¿e 
dokumentacje towarzysz±ce poszczególnym pakietom oprogramowania. 
Wiêkszo¶æ programów posiada opcjê uruchamiania --help, która mo¿e 
u³atwiæ rozpoczêcie pracy. 

Informacje licencyjne (w jêzyku angielskim) dotycz±ce redystrybucji
mo¿na znale¼æ w plikach tekstowych: [1]LICENSE.TL oraz [2]LICENSE.CTAN.
 
Jak zacz±æ

Przed rozpoczêciem instalowania warto przeczytaæ Przewodnik po TeX Live. 
Zawiera on informacje niezbêdne do korzystania z dystrybucji i prawid³owej 
instalacji systemu TeX. Gdy instalujemy z p³ytki DVD, wersje Przewodnika 
w kilku jêzykach dostêpne s± w formatach HTML i PDF w podkatalogach 
katalogu [3]texlive-doc. Po zainstalowaniu Przewodnik i jego t³umaczenia
znajdziemy w podkatalogach [4]texmf-dist/doc/texlive.

Uwaga: poni¿sze odno¶niki nie dzia³aj±, gdy instalujemy TeX Live 
z internetu. W tym wypadku nale¿y siêgn±æ do dokumentacji udostêpnionej 
w sieci: [5]http://tug.org/texlive/doc.html

Przewodnik po TeX Live (polskie t³umaczenie): 
  [6]PDF:  texmf-dist/doc/texlive/texlive-pl/texlive-pl.pdf 
  [7]HTML: texmf-dist/doc/texlive/texlive-pl/texlive-pl.html 

The TeX Live Guide (w jêzyku angielskim): 
  [8]PDF:  texmf-dist/doc/texlive/texlive-en/texlive-en.pdf 
  [9]HTML: texmf-dist/doc/texlive/texlive-en/texlive-en.html 

Lista najwa¿niejszych zmian znajduje siê na koñcu
dokumentacji w rozdziale [10],,Historia. Wydanie obecne''.

Instalacja

Programem instalacyjnym jest obecnie skrypt install-tl (install-tl.bat
dla Windows), który posiada trzy tryby pracy: 

"wizard" (domy¶lny dla Windows) graficzny GUI, który ma ograniczon±
do minimum listê zapytañ i instaluje wszystkie pakiety. Odpowiada to
uruchomieniu polecenia: install-tl --gui=wizard

tekstowy (domy¶lny dla innych systemów). Odpowiada to uruchomieniu 
polecenia: install-tl --gui=text

perltk - graficzny tryb, szczególnie przydatny dla zaawansowanych 
u¿ytkowników Windows, którzy chc± dokonaæ wyboru pakietów i ustawieñ. 
Uruchamiany jest poleceniem: install-tl --gui=perltk (lub 
w Windows poleceniem install-tl-advanced.bat).

Po zainstalowaniu proponujemy u¿ycie tlmgr (TeX Live Manager),
który posiada dwa tryby pracy (graficzny i tekstowy) i umo¿liwia 
dodawanie b±d¼ usuwanie pakietów, ich aktualizacjê z internetu i czynno¶ci
konfiguracyjne.

Zarówno [11]install-tl, jak i [12]tlmgr mo¿na uruchomiæ z parametrem --help,
aby wy¶wietliæ wszystkie dostêpne opcje.

Dokumentacje

Wiêkszo¶æ dokumentacji po instalacji mo¿e byæ przegl±dana bez konieczno¶ci 
ich uprzedniego generowania. Zazwyczaj s± to pliki w formatach HTML 
i/lub PDF. 

[13]doc.html Katalog dostêpnych w instalacji dokumentacji w formatach PDF i HTML 
[14]texmf-dist/doc/generic/FAQ-en/newfaq.pdf  TeX Frequently Asked Questions 
                                     (odpowiedzi na czêsto zadawane pytania)

Wybrane strony, dostêpne w sieci: 
 [15]http://tug.org/begin.html Strona TeX Users Group dla pocz±tkuj±cych; 
                               zawiera odes³ania do podstawowych 
                               podrêczników; 
 [16]http://tug.org/interest.html TeX w Sieci, obszerny wybór odsy³aczy 
                               do stron WWW dotycz±cych TeX-a; 
 [17]http://tug.org/ctan.html  Dostêp do ¶wiatowych archiwów TeX-owych CTAN 
                               (Comprehensive TeX Archive Network; 
 [18]http://tug.org/usegroups.html Informacje nt. TeX Users Group i lokalnych 
                               grup u¿ytkowników systemu TeX. 

Polskie pakiety i dokumentacje

TeX Live zawiera wiêkszo¶æ dostêpnego polskiego oprogramowania
TeX-owego i reprezentatywny wybór dokumentacji. Wirtualna Akademia TeX-owa,
prowadzona w ramach polskiej Grupy U¿ytkowników Systemu TeX GUST, 
przedstawia system TeX, a ponadto zawiera opisy wielu praktycznych makr 
i programów. Pocz±tkuj±cym polecamy szczególnie Przewodnik po systemie 
TeX (texmf-dist/doc/generic/tex-virtual-academy-pl/cototex.html).

TeX Live zawiera ponadto gotowy do u¿ycia format MeX (polski
odpowiednik formatu Plain). Format LaTeX2e jest przystosowany do obs³ugi
jêzyka polskiego po za³adowaniu pakietu "polski". Dostêpne s± oczywi¶cie 
pliki ¼ród³owe pakietów MeX i "polski" oraz fonty przygotowane specjalnie 
do u¿ycia w polskojêzycznym TeX-u.

Dodatkowe programy, przydatne dla polskich u¿ytkowników, umieszczone 
zosta³y w katalogu texmf-dist/doc/support/gustprog/ (patrz README). 
Wybór przydatnych makr dla u¿ytkowników przede wszystkim formatu 
Plain/MeX oraz makra i style do tworzenia polskich skorowidzów 
i bibliografii mo¿na znale¼æ w katalogu texmf-dist/tex/plain/gustlib 
(patrz README). 

Warto te¿ zajrzeæ na stronê polskiej Grupy U¿ytkowników Systemu TeX GUST: 
http://www.gust.org.pl 
Oprócz informacji o dzia³alno¶ci grupy, mo¿na tam znale¼æ sporo materia³ów, 
które powinny zainteresowaæ polskojêzycznych u¿ytkowników TeX-a.

Mi³ego TeX-owania! 

Strona projektu TeX Live: [19]http://tug.org/tex-live. 

Odno¶niki

   1. file:LICENSE.TL
   2. file:LICENSE.CTAN
   3. file:texlive-doc
   4. texmf-dist/doc/texlive
   5. http://tug.org/texlive/doc.html
   6. file:texmf-dist/doc/texlive/texlive-pl/texlive-pl.pdf 
   7. file:texmf-dist/doc/texlive/texlive-pl/texlive-pl.html 
   8. file:texmf-dist/doc/texlive/texlive-en/texlive-en.pdf
   9. file:texmf-dist/doc/texlive/texlive-en/texlive-en.html
  10. file:texmf-dist/doc/texlive/texlive-pl/texlive-pl.html
  11. http://tug.org/texlive/doc/install-tl.html
  12. http://tug.org/texlive/tlmgr.html
  13. file:doc.html
  14. file:texmf-dist/doc/generic/FAQ-en/newfaq.pdf
  15. http://tug.org/begin.html
  16. http://tug.org/interest.html
  17. http://tug.org/ctan.html
  18. http://tug.org/usergroups.html
  19. http://tug.org/texlive/


