%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mathabx.dcl. Version: May 18, 2005.
% Author: Anthony PHAN.
% matches the ``mathabx'' family.
% names almost fit newmath.sty (Matthias Clasen, Ulrik Vieth)
% not necessarily designs...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\catcode`\@=11
%\mathabx@undefine{\models} ????
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% to be defined
%\DeclareMathSymbol{\bigtriangleup}{2}{matha}{"}
%\DeclareMathSymbol{\bigtriangledown}{2}{matha}{"}
%\DeclareMathSymbol{\square}{0}{matha}{"}
%
\symbol@message{Specials (matha/mathb)}
%
\mathabx@matha
\DeclareMathSymbol{\notsign}       {3}{matha}{"7F}
\end@mathabx
\mathabx@mathb
\DeclareMathSymbol{\varnotsign}    {3}{mathb}{"7F}
\end@mathabx
\mathabx@matha
\DeclareMathSymbol{\cdotp}         {6}{matha}{"04}% oddity
\end@mathabx
%
\mathabx@matha
\symbol@message{Usual binary operators (matha)}
%
\DeclareMathSymbol{+}              {2}{matha}{"00}
\DeclareMathSymbol{-}              {2}{matha}{"01}
\DeclareMathSymbol{\times}         {2}{matha}{"02}
\DeclareMathSymbol{\div}           {2}{matha}{"03}
\DeclareMathSymbol{\cdot}          {2}{matha}{"04}
\DeclareMathSymbol{\circ}          {2}{matha}{"05}
\DeclareMathSymbol{*}              {2}{matha}{"06}
\DeclareMathSymbol{\ast}           {2}{matha}{"06}
\DeclareMathSymbol{\asterisk}      {0}{matha}{"06}
\DeclareMathSymbol{\coasterisk}    {2}{matha}{"07}
\DeclareMathSymbol{\pm}            {2}{matha}{"08}
\DeclareMathSymbol{\mp}            {2}{matha}{"09}
\DeclareMathSymbol{\ltimes}        {2}{matha}{"0A}
\DeclareMathSymbol{\rtimes}        {2}{matha}{"0B}
\DeclareMathSymbol{\diamond}       {2}{matha}{"0C}
\DeclareMathSymbol{\bullet}        {2}{matha}{"0D}
\DeclareMathSymbol{\star}          {2}{matha}{"0E}
\DeclareMathSymbol{\varstar}       {2}{matha}{"0F}
\DeclareMathSymbol{\ssum}          {2}{matha}{"3C}
\DeclareMathSymbol{\sprod}         {2}{matha}{"3D}
\DeclareMathSymbol{\amalg}         {2}{matha}{"3E}
\mathabx@aliases\amalg\scoprod
\end@mathabx
%
\mathabx@mathb
\symbol@message{Unusual binary operators (mathb)}
%
\DeclareMathSymbol{\dotplus}       {2}{mathb}{"00}% name to be checked
\DeclareMathSymbol{\dotdiv}        {2}{mathb}{"01}% name to be checked
\DeclareMathSymbol{\dottimes}      {2}{mathb}{"02}% name to be checked
\DeclareMathSymbol{\divdot}        {2}{mathb}{"03}% name to be checked
\DeclareMathSymbol{\udot}          {2}{mathb}{"04}% name to be checked
\DeclareMathSymbol{\square}        {2}{mathb}{"05}% name to be checked
\DeclareMathSymbol{\Asterisk}      {2}{mathb}{"06}
\DeclareMathSymbol{\bigast}        {1}{mathb}{"06}
\DeclareMathSymbol{\coAsterisk}    {2}{mathb}{"07}
\DeclareMathSymbol{\bigcoast}      {1}{mathb}{"07}
\DeclareMathSymbol{\circplus}      {2}{mathb}{"08}% name to be checked
\DeclareMathSymbol{\pluscirc}      {2}{mathb}{"09}% name to be checked
\DeclareMathSymbol{\convolution}   {2}{mathb}{"0A}% name to be checked
\DeclareMathSymbol{\divideontimes} {2}{mathb}{"0B}% name to be checked
\DeclareMathSymbol{\blackdiamond}  {2}{mathb}{"0C}% name to be checked
\DeclareMathSymbol{\sqbullet}      {2}{mathb}{"0D}% name to be checked
	\mathabx@aliases\sqbullet\centerdot
\DeclareMathSymbol{\bigstar}       {2}{mathb}{"0E}
\DeclareMathSymbol{\bigvarstar}    {2}{mathb}{"0F}
\end@mathabx
%
\mathabx@matha
\symbol@message{Usual relations (matha)}
%
\DeclareMathSymbol{=}              {3}{matha}{"10}
\DeclareMathSymbol{\equiv}         {3}{matha}{"11}
\DeclareMathSymbol{\sim}           {3}{matha}{"12}
\DeclareMathSymbol{\approx}        {3}{matha}{"13}
\DeclareMathSymbol{\simeq}         {3}{matha}{"14}
\mathabx@undefine{\cong}
\DeclareMathSymbol{\cong}          {3}{matha}{"15}
\DeclareMathSymbol{\asymp}         {3}{matha}{"16}
\DeclareMathSymbol{\divides}       {3}{matha}{"17}
%
\mathabx@undefine{\neq}
\DeclareMathSymbol{\neq}           {3}{matha}{"18}
	\mathabx@aliases\neq\ne
\DeclareMathSymbol{\notequiv}      {3}{matha}{"19}
	\mathabx@aliases\notequiv\nequiv
\DeclareMathSymbol{\nsim}          {3}{matha}{"1A}
\DeclareMathSymbol{\napprox}       {3}{matha}{"1B}
\DeclareMathSymbol{\nsimeq}        {3}{matha}{"1C}
\DeclareMathSymbol{\ncong}         {3}{matha}{"1D}
\DeclareMathSymbol{\notasymp}      {3}{matha}{"1E}
\DeclareMathSymbol{\notdivides}    {3}{matha}{"1F}
	\mathabx@aliases\notdivides\ndivides
%
%\DeclareMathSymbol{\approxeq}     {3}{matha}{"1C}% name to be checked
%\DeclareMathSymbol{\eqsim}        {3}{matha}{"1E}% name to be checked
%\DeclareMathSymbol{\napproxeq}    {3}{matha}{"1D}
%\DeclareMathSymbol{\neqsim}       {3}{matha}{"1F}
\end@mathabx
%
\mathabx@mathb
\symbol@message{Unusual relations (mathb)}
%
\DeclareMathSymbol{\topdoteq}      {3}{mathb}{"10}% name to be checked
\DeclareMathSymbol{\botdoteq}      {3}{mathb}{"11}% name to be checked
\DeclareMathSymbol{\dotseq}        {3}{mathb}{"12}% name to be checked
	\mathabx@aliases\dotseq{\doteqdot\Doteq}%
\DeclareMathSymbol{\risingdotseq}  {3}{mathb}{"13}% name to be checked
\DeclareMathSymbol{\fallingdotseq} {3}{mathb}{"14}% name to be checked
\DeclareMathSymbol{\coloneq}       {3}{mathb}{"15}% name to be checked
\DeclareMathSymbol{\eqcolon}       {3}{mathb}{"16}% name to be checked
\DeclareMathSymbol{\bumpedeq}      {3}{mathb}{"17}% name to be checked
\DeclareMathSymbol{\eqbumped}      {3}{mathb}{"18}% name to be checked
\DeclareMathSymbol{\Bumpedeq}      {3}{mathb}{"19}% name to be checked
\DeclareMathSymbol{\circeq}        {3}{mathb}{"1A}% name to be checked
\DeclareMathSymbol{\eqcirc}        {3}{mathb}{"1B}% name to be checked
\DeclareMathSymbol{\triangleq}     {3}{mathb}{"1C}% name to be checked
\DeclareMathSymbol{\corresponds}   {3}{mathb}{"1D}% name to be checked
\end@mathabx
%
\mathabx@matha
\symbol@message{Miscellaneous (matha)}
%
\DeclareMathSymbol{\neg}           {0}{matha}{"20}
	\mathabx@aliases\neg\lnot
\DeclareMathSymbol{\ll}            {3}{matha}{"21}
\DeclareMathSymbol{\gg}            {3}{matha}{"22}
\DeclareMathSymbol{\hash}          {0}{matha}{"23}
\DeclareMathSymbol{\vdash}         {3}{matha}{"24}
\DeclareMathSymbol{\dashv}         {3}{matha}{"25}
\DeclareMathSymbol{\nvdash}        {3}{matha}{"26}
\DeclareMathSymbol{\ndashv}        {3}{matha}{"27}
\DeclareMathSymbol{\vDash}         {3}{matha}{"28}
\DeclareMathSymbol{\Dashv}         {3}{matha}{"29}
\DeclareMathSymbol{\nvDash}        {3}{matha}{"2A}
\DeclareMathSymbol{\nDashv}        {3}{matha}{"2B}
\DeclareMathSymbol{\Vdash}         {3}{matha}{"2C}
\DeclareMathSymbol{\dashV}         {3}{matha}{"2D}
\DeclareMathSymbol{\nVdash}        {3}{matha}{"2E}
\DeclareMathSymbol{\ndashV}        {3}{matha}{"2F}
%
\DeclareMathSymbol{\degree}        {0}{matha}{"30}
\mathabx@undefine{\prime}
\DeclareMathSymbol{\prime}         {0}{matha}{"31}
\DeclareMathSymbol{\second}        {0}{matha}{"32}
\DeclareMathSymbol{\third}         {0}{matha}{"33}
\DeclareMathSymbol{\fourth}        {0}{matha}{"34}
\DeclareMathSymbol{\flat}          {0}{matha}{"35}
\DeclareMathSymbol{\natural}       {0}{matha}{"36}
\DeclareMathSymbol{\sharp}         {0}{matha}{"37}
\DeclareMathSymbol{\infty}         {0}{matha}{"38}
\DeclareMathSymbol{\propto}        {0}{matha}{"39}
\DeclareMathSymbol{\dagger}        {0}{matha}{"3A}
\DeclareMathSymbol{\ddagger}       {0}{matha}{"3B}
\end@mathabx
%
\mathabx@mathb
\symbol@message{Miscellaneous (mathb)}
%
\DeclareMathSymbol{\between}       {3}{mathb}{"20}
\DeclareMathSymbol{\smile}         {3}{mathb}{"21}
\DeclareMathSymbol{\frown}         {3}{mathb}{"22}
\DeclareMathSymbol{\varhash}       {0}{mathb}{"23}
\DeclareMathSymbol{\leftthreetimes} {0}{mathb}{"24}
\DeclareMathSymbol{\rightthreetimes}{0}{mathb}{"25}
\DeclareMathSymbol{\pitchfork}     {0}{mathb}{"26}
\mathabx@undefine{\bowtie}
\DeclareMathSymbol{\bowtie}        {3}{mathb}{"27}
	\mathabx@aliases\bowtie\Join
\DeclareMathSymbol{\VDash}         {3}{mathb}{"28}
\DeclareMathSymbol{\DashV}         {3}{mathb}{"29}
\DeclareMathSymbol{\nVDash}        {3}{mathb}{"2A}
\DeclareMathSymbol{\nDashV}        {3}{mathb}{"2B}
\DeclareMathSymbol{\Vvdash}        {3}{mathb}{"2C}
\DeclareMathSymbol{\dashVv}        {3}{mathb}{"2D}
\DeclareMathSymbol{\nVvash}        {3}{mathb}{"2E}
\DeclareMathSymbol{\ndashVv}       {3}{mathb}{"2F}
%
\DeclareMathSymbol{\therefore}     {3}{mathb}{"36}
\DeclareMathSymbol{\because}       {3}{mathb}{"37}
\DeclareMathAccent{\ring}          {0}{mathb}{"38}
\mathabx@undefine{\dot}
\DeclareMathAccent{\dot}           {0}{mathb}{"39}
\mathabx@undefine{\ddot}
\DeclareMathAccent{\ddot}          {0}{mathb}{"3A}
\mathabx@undefine{\dddot}
\DeclareMathAccent{\dddot}         {0}{mathb}{"3B}
\mathabx@undefine{\ddddot}
\DeclareMathAccent{\ddddot}        {0}{mathb}{"3C}
\mathabx@undefine{\angle}
\DeclareMathSymbol{\angle}         {0}{mathb}{"3D}
\DeclareMathSymbol{\measuredangle} {0}{mathb}{"3E}
\DeclareMathSymbol{\sphericalangle}{0}{mathb}{"3F}
\DeclareMathSymbol{\rip}           {0}{mathb}{"4F}
\end@mathabx
%
\mathabx@matha
\symbol@message{Delimiters as symbols (matha)}
%
\DeclareMathSymbol{(}              {4}{matha}{"70}
\DeclareMathSymbol{)}              {5}{matha}{"71}
\DeclareMathSymbol{[}              {4}{matha}{"72}
\DeclareMathSymbol{]}              {5}{matha}{"73}
%\DeclareMathSymbol{\lbrace}       {4}{matha}{"74}% extens. delimiter
%\DeclareMathSymbol{\rbrace}       {5}{matha}{"75}% extens. delimiter
% \mathabx@undefine{\backslash}
% \DeclareMathSymbol{\backslash}   {0}{matha}{"7A}% extens. delimiter
\DeclareMathSymbol{\setminus}      {0}{matha}{"7A}
\DeclareMathSymbol{/}              {0}{matha}{"7B}
\mathabx@undefine{\|}
\DeclareMathSymbol{|}              {0}{matha}{"7C}
\DeclareMathSymbol{\mid}           {3}{matha}{"7C}
% \DeclareMathSymbol{\|}           {0}{matha}{"7D}% extens. delimiter
% \DeclareMathSymbol{\vvvert}      {0}{matha}{"7E}% extens. delimiter
\end@mathabx
%
\mathabx@mathb
\symbol@message{Delimiters as symbols (mathb)}
%
\DeclareMathSymbol{\lcorners}      {4}{mathb}{"76}% name to be checked
\DeclareMathSymbol{\rcorners}      {5}{mathb}{"77}% name to be checked
\mathabx@undefine{\ulcorner}
\DeclareMathSymbol{\ulcorner}      {4}{mathb}{"78}% name to be checked
\mathabx@undefine{\urcorner}
\DeclareMathSymbol{\urcorner}      {5}{mathb}{"79}% name to be checked
\mathabx@undefine{\llcorner}
\DeclareMathSymbol{\llcorner}      {4}{mathb}{"7A}% name to be checked
\mathabx@undefine{\lrcorner}
\DeclareMathSymbol{\lrcorner}      {5}{mathb}{"7B}% name to be checked
%
\symbol@message{Astronomical symbols (mathb)}
%
\DeclareMathSymbol{\Sun}           {0}{mathb}{"40}
\DeclareMathSymbol{\Mercury}       {0}{mathb}{"41}
\DeclareMathSymbol{\Venus}         {0}{mathb}{"42}
	\mathabx@aliases\Venus\girl
\DeclareMathSymbol{\Earth}         {0}{mathb}{"43}
\DeclareMathSymbol{\Mars}          {0}{mathb}{"44}
	\mathabx@aliases\Mars\boy
\DeclareMathSymbol{\Jupiter}       {0}{mathb}{"45}
\DeclareMathSymbol{\Saturn}        {0}{mathb}{"46}
\DeclareMathSymbol{\Uranus}        {0}{mathb}{"47}
\DeclareMathSymbol{\Neptune}       {0}{mathb}{"48}
\DeclareMathSymbol{\Pluto}         {0}{mathb}{"49}
\DeclareMathSymbol{\varEarth}      {0}{mathb}{"4A}
\DeclareMathSymbol{\leftmoon}      {0}{mathb}{"4B}
	\mathabx@aliases\leftmoon\Moon
\DeclareMathSymbol{\rightmoon}     {0}{mathb}{"4C}
\DeclareMathSymbol{\fullmoon}      {0}{mathb}{"4D}
\DeclareMathSymbol{\newmoon}       {0}{mathb}{"4E}
%
\DeclareMathSymbol{\Aries}         {0}{mathb}{"50}
\DeclareMathSymbol{\Taurus}        {0}{mathb}{"51}
\DeclareMathSymbol{\Gemini}        {0}{mathb}{"52}
%\DeclareMathSymbol{\Cancer}      {0}{mathb}{"53}
\DeclareMathSymbol{\Leo}         {0}{mathb}{"54}
%\DeclareMathSymbol{\Virgo}       {0}{mathb}{"55}
\DeclareMathSymbol{\Libra}         {0}{mathb}{"56}
\DeclareMathSymbol{\Scorpio}       {0}{mathb}{"57}
%\DeclareMathSymbol{\Sagittarius} {0}{mathb}{"58}
%\DeclareMathSymbol{\Capricornus} {0}{mathb}{"59}
%\DeclareMathSymbol{\Aquarius}    {0}{mathb}{"59}
%\DeclareMathSymbol{\Pisces}      {0}{mathb}{"59}
\end@mathabx
%
\mathabx@matha
\symbol@message{Letter like symbols (matha)}
%
\DeclareMathSymbol{\forall}        {0}{matha}{"40}
\DeclareMathSymbol{\complement}    {0}{matha}{"41}
\DeclareMathSymbol{\partial}       {0}{matha}{"42}
%	\mathabx@aliases\partial\partialit
\DeclareMathSymbol{\partialslash}  {0}{matha}{"43}
\DeclareMathSymbol{\exists}        {0}{matha}{"44}
\DeclareMathSymbol{\nexists}       {0}{matha}{"45}
\DeclareMathSymbol{\Finv}          {0}{matha}{"46}
\DeclareMathSymbol{\Game}          {0}{matha}{"47}
\DeclareMathSymbol{\emptyset}      {0}{matha}{"48}
\DeclareMathSymbol{\diameter}      {0}{matha}{"49}
\DeclareMathSymbol{\top}           {0}{matha}{"4A}
\DeclareMathSymbol{\bot}           {0}{matha}{"4B}
\DeclareMathSymbol{\perp}          {3}{matha}{"4B}
\DeclareMathSymbol{\nottop}        {0}{matha}{"4C}
\DeclareMathSymbol{\notbot}        {0}{matha}{"4D}
\DeclareMathSymbol{\notperp}       {3}{matha}{"4D}
\DeclareMathSymbol{\curlywedge}    {2}{matha}{"4E}
\DeclareMathSymbol{\curlyvee}      {2}{matha}{"4F}
%
\DeclareMathSymbol{\in}            {3}{matha}{"50}
\DeclareMathSymbol{\owns}          {3}{matha}{"51}
	\mathabx@aliases\owns\ni
\mathabx@undefine{\notin}
\DeclareMathSymbol{\notin}         {3}{matha}{"52}
\DeclareMathSymbol{\notowner}      {3}{matha}{"53}
	\mathabx@aliases\notowner{\notni\notowns}%
\DeclareMathSymbol{\varnotin}      {3}{matha}{"54}
\DeclareMathSymbol{\varnotowner}   {3}{matha}{"55}
\DeclareMathSymbol{\barin}         {3}{matha}{"56}% name to be checked
\DeclareMathSymbol{\ownsbar}       {3}{matha}{"57}% name to be checked
	\mathabx@aliases\ownsbar\nibar% Arghl
%
\DeclareMathSymbol{\cap}           {2}{matha}{"58}
\DeclareMathSymbol{\cup}           {2}{matha}{"59}
\DeclareMathSymbol{\uplus}         {2}{matha}{"5A}
\DeclareMathSymbol{\sqcap}         {2}{matha}{"5B}
\DeclareMathSymbol{\sqcup}         {2}{matha}{"5C}
\DeclareMathSymbol{\squplus}       {2}{matha}{"5D}
\DeclareMathSymbol{\wedge}         {2}{matha}{"5E}
	\mathabx@aliases\wedge\land
\DeclareMathSymbol{\vee}           {2}{matha}{"5F}
	\mathabx@aliases\vee\lor
\end@mathabx
%
\mathabx@mathb
\symbol@message{Letter like symbols (mathb)}
%
\DeclareMathSymbol{\barwedge}      {2}{mathb}{"58}
\DeclareMathSymbol{\veebar}        {2}{mathb}{"59}
\DeclareMathSymbol{\doublebarwedge}{2}{mathb}{"5A}
\DeclareMathSymbol{\veedoublebar}  {2}{mathb}{"5B}
\DeclareMathSymbol{\doublecap}     {2}{mathb}{"5C}
	\mathabx@aliases\doublecap\Cap
\DeclareMathSymbol{\doublecup}     {2}{mathb}{"5D}
	\mathabx@aliases\doublecup\Cup
\DeclareMathSymbol{\sqdoublecap}   {2}{mathb}{"5E}
	\mathabx@aliases\sqdoublecap\sqCap
\DeclareMathSymbol{\sqdoublecup}   {2}{mathb}{"5F}
	\mathabx@aliases\sqdoublecup\sqCup
\end@mathabx
%
\mathabx@matha
\symbol@message{Subset's and superset's signs (matha)}
%
\DeclareMathSymbol{\subset}        {3}{matha}{"80}
\DeclareMathSymbol{\supset}        {3}{matha}{"81}
\DeclareMathSymbol{\nsubset}       {3}{matha}{"82}
\DeclareMathSymbol{\nsupset}       {3}{matha}{"83}
\DeclareMathSymbol{\subseteq}      {3}{matha}{"84}
\DeclareMathSymbol{\supseteq}      {3}{matha}{"85}
\DeclareMathSymbol{\nsubseteq}     {3}{matha}{"86}
\DeclareMathSymbol{\nsupseteq}     {3}{matha}{"87}
\DeclareMathSymbol{\subsetneq}     {3}{matha}{"88}
\DeclareMathSymbol{\supsetneq}     {3}{matha}{"89}
\DeclareMathSymbol{\varsubsetneq}  {3}{matha}{"8A}
\DeclareMathSymbol{\varsupsetneq}  {3}{matha}{"8B}
%
\DeclareMathSymbol{\subseteqq}     {3}{matha}{"8C}
\DeclareMathSymbol{\supseteqq}     {3}{matha}{"8D}
\DeclareMathSymbol{\nsubseteqq}    {3}{matha}{"8E}
\DeclareMathSymbol{\nsupseteqq}    {3}{matha}{"8F}
\DeclareMathSymbol{\subsetneqq}    {3}{matha}{"90}
\DeclareMathSymbol{\supsetneqq}    {3}{matha}{"91}
\DeclareMathSymbol{\varsubsetneqq} {3}{matha}{"92}
\DeclareMathSymbol{\varsupsetneqq} {3}{matha}{"93}
%
\DeclareMathSymbol{\Subset}        {3}{matha}{"94}
\DeclareMathSymbol{\Supset}        {3}{matha}{"95}
\DeclareMathSymbol{\nSubset}       {3}{matha}{"96}
\DeclareMathSymbol{\nSupset}       {3}{matha}{"97}
\end@mathabx
%
\mathabx@mathb
\symbol@message{Square subset's and superset's signs (mathb)}
\mathabx@undefine{\sqsubset}
\DeclareMathSymbol{\sqsubset}       {3}{mathb}{"80}
\mathabx@undefine{\sqsupset}
\DeclareMathSymbol{\sqsupset}       {3}{mathb}{"81}
\DeclareMathSymbol{\nsqsubset}      {3}{mathb}{"82}
\DeclareMathSymbol{\nsqsupset}      {3}{mathb}{"83}
\DeclareMathSymbol{\sqsubseteq}     {3}{mathb}{"84}
\DeclareMathSymbol{\sqsupseteq}     {3}{mathb}{"85}
\DeclareMathSymbol{\nsqsubseteq}    {3}{mathb}{"86}
\DeclareMathSymbol{\nsqsupseteq}    {3}{mathb}{"87}
\DeclareMathSymbol{\sqsubsetneq}    {3}{mathb}{"88}
\DeclareMathSymbol{\sqsupsetneq}    {3}{mathb}{"89}
\DeclareMathSymbol{\varsqsubsetneq} {3}{mathb}{"8A}
\DeclareMathSymbol{\varsqsupsetneq} {3}{mathb}{"8B}
%
\DeclareMathSymbol{\sqsubseteqq}    {3}{mathb}{"8C}
\DeclareMathSymbol{\sqsupseteqq}    {3}{mathb}{"8D}
\DeclareMathSymbol{\nsqsubseteqq}   {3}{mathb}{"8E}
\DeclareMathSymbol{\nsqsupseteqq}   {3}{mathb}{"8F}
\DeclareMathSymbol{\sqsubsetneqq}   {3}{mathb}{"90}
\DeclareMathSymbol{\sqsupsetneqq}   {3}{mathb}{"91}
\DeclareMathSymbol{\varsqsubsetneqq}{3}{mathb}{"92}
\DeclareMathSymbol{\varsqsupsetneqq}{3}{mathb}{"93}
%
\DeclareMathSymbol{\sqSubset}       {3}{mathb}{"94}
\DeclareMathSymbol{\sqSupset}       {3}{mathb}{"95}
\DeclareMathSymbol{\nsqSubset}      {3}{mathb}{"96}
\DeclareMathSymbol{\nsqSupset}      {3}{mathb}{"97}
\end@mathabx
%
\mathabx@matha
\symbol@message{Triangles as relations (matha)}
%
\DeclareMathSymbol{\triangleleft}    {2}{matha}{"98}
\DeclareMathSymbol{\vartriangleleft} {3}{matha}{"98}
\DeclareMathSymbol{\triangleright}   {2}{matha}{"99}
\DeclareMathSymbol{\vartriangleright}{3}{matha}{"99}
\DeclareMathSymbol{\ntriangleleft}   {3}{matha}{"9A}
\DeclareMathSymbol{\ntriangleright}  {3}{matha}{"9B}
\DeclareMathSymbol{\trianglelefteq}  {3}{matha}{"9C}
\DeclareMathSymbol{\trianglerighteq} {3}{matha}{"9D}
\DeclareMathSymbol{\ntrianglelefteq} {3}{matha}{"9E}
\DeclareMathSymbol{\ntrianglerighteq}{3}{matha}{"9F}
\end@mathabx
%
\mathabx@mathb
\symbol@message{Triangles as binary operators (mathb)}
%
\DeclareMathSymbol{\smalltriangleup}   {2}{mathb}{"98}% name to be checked
\DeclareMathSymbol{\smalltriangledown} {2}{mathb}{"99}% name to be checked
\DeclareMathSymbol{\smalltriangleleft} {2}{mathb}{"9A}% name to be checked
\DeclareMathSymbol{\smalltriangleright}{2}{mathb}{"9B}% name to be checked
\DeclareMathSymbol{\blacktriangleup}   {2}{mathb}{"9C}% name to be checked
\DeclareMathSymbol{\blacktriangledown} {2}{mathb}{"9D}% name to be checked
\DeclareMathSymbol{\blacktriangleleft} {2}{mathb}{"9E}% name to be checked
\DeclareMathSymbol{\blacktriangleright}{2}{mathb}{"9F}% name to be checked
\end@mathabx
%
\mathabx@matha
\symbol@message{Inequalities (matha)}
%
\DeclareMathSymbol{<}            {3}{matha}{"A0}
\DeclareMathSymbol{>}            {3}{matha}{"A1}
\DeclareMathSymbol{\nless}       {3}{matha}{"A2}
\DeclareMathSymbol{\ngtr}        {3}{matha}{"A3}
\DeclareMathSymbol{\leq}         {3}{matha}{"A4}
	\mathabx@aliases\leq{\le\leqslant}%
\DeclareMathSymbol{\geq}         {3}{matha}{"A5}
	\mathabx@aliases\geq{\ge\geqslant}%
\DeclareMathSymbol{\nleq}        {3}{matha}{"A6}
	\mathabx@aliases\nleq\nleqslant 
\DeclareMathSymbol{\ngeq}        {3}{matha}{"A7}
	\mathabx@aliases\ngeq\ngeqslant
\DeclareMathSymbol{\varleq}      {3}{matha}{"A8}
\DeclareMathSymbol{\vargeq}      {3}{matha}{"A9}
\DeclareMathSymbol{\nvarleq}     {3}{matha}{"AA}
\DeclareMathSymbol{\nvargeq}     {3}{matha}{"AB}
\DeclareMathSymbol{\lneq}        {3}{matha}{"AC}
\DeclareMathSymbol{\gneq}        {3}{matha}{"AD}
\DeclareMathSymbol{\leqq}        {3}{matha}{"AE}
\DeclareMathSymbol{\geqq}        {3}{matha}{"AF}
\DeclareMathSymbol{\nleqq}       {3}{matha}{"B0}
\DeclareMathSymbol{\ngeqq}       {3}{matha}{"B1}
\DeclareMathSymbol{\lneqq}       {3}{matha}{"B2}
\DeclareMathSymbol{\gneqq}       {3}{matha}{"B3}
\DeclareMathSymbol{\lvertneqq}   {3}{matha}{"B4}
\DeclareMathSymbol{\gvertneqq}   {3}{matha}{"B5}
\DeclareMathSymbol{\eqslantless} {3}{matha}{"B6}
\DeclareMathSymbol{\eqslantgtr}  {3}{matha}{"B7}
\DeclareMathSymbol{\neqslantless}{3}{matha}{"B8}
\DeclareMathSymbol{\neqslantgtr} {3}{matha}{"B9}
\DeclareMathSymbol{\lessgtr}     {3}{matha}{"BA}
\DeclareMathSymbol{\gtrless}     {3}{matha}{"BB}
\DeclareMathSymbol{\lesseqgtr}   {3}{matha}{"BC}
\DeclareMathSymbol{\gtreqless}   {3}{matha}{"BD}
\DeclareMathSymbol{\lesseqqgtr}  {3}{matha}{"BE}
\DeclareMathSymbol{\gtreqqless}  {3}{matha}{"BF}
%
\DeclareMathSymbol{\lesssim}     {3}{matha}{"C0}
\DeclareMathSymbol{\gtrsim}      {3}{matha}{"C1}
\DeclareMathSymbol{\nlesssim}    {3}{matha}{"C2}
\DeclareMathSymbol{\ngtrsim}     {3}{matha}{"C3}
\DeclareMathSymbol{\lnsim}       {3}{matha}{"C4}
\DeclareMathSymbol{\gnsim}       {3}{matha}{"C5}
\DeclareMathSymbol{\lessapprox}  {3}{matha}{"C6}
\DeclareMathSymbol{\gtrapprox}   {3}{matha}{"C7}
\DeclareMathSymbol{\nlessapprox} {3}{matha}{"C8}
\DeclareMathSymbol{\ngtrapprox}  {3}{matha}{"C9}
\DeclareMathSymbol{\lnapprox}    {3}{matha}{"CA}
\DeclareMathSymbol{\gnapprox}    {3}{matha}{"CB}
%
\DeclareMathSymbol{\lessdot}     {3}{matha}{"CC}
\DeclareMathSymbol{\gtrdot}      {3}{matha}{"CD}
%
\DeclareMathSymbol{\lll}         {3}{matha}{"CE}
\DeclareMathSymbol{\ggg}         {3}{matha}{"CF}
%
\DeclareMathSymbol{\precdot}     {3}{matha}{"CC}
\DeclareMathSymbol{\succdot}     {3}{matha}{"CD}
\end@mathabx
%
\mathabx@mathb
\symbol@message{Inequalities (mathb)}
%
\DeclareMathSymbol{\prec}        {3}{mathb}{"A0}
\DeclareMathSymbol{\succ}        {3}{mathb}{"A1}
\DeclareMathSymbol{\nprec}       {3}{mathb}{"A2}
\DeclareMathSymbol{\nsucc}       {3}{mathb}{"A3}
\DeclareMathSymbol{\preccurlyeq} {3}{mathb}{"A4}
\DeclareMathSymbol{\succcurlyeq} {3}{mathb}{"A5}
\DeclareMathSymbol{\npreccurlyeq}{3}{mathb}{"A6}
\DeclareMathSymbol{\nsucccurlyeq}{3}{mathb}{"A7}
\DeclareMathSymbol{\preceq}      {3}{mathb}{"A8}
\DeclareMathSymbol{\succeq}      {3}{mathb}{"A9}
\DeclareMathSymbol{\npreceq}     {3}{mathb}{"AA}
\DeclareMathSymbol{\nsucceq}     {3}{mathb}{"AB}
\DeclareMathSymbol{\precneq}     {3}{mathb}{"AC}
\DeclareMathSymbol{\succneq}     {3}{mathb}{"AD}
\DeclareMathSymbol{\curlyeqprec} {3}{mathb}{"B6}
\DeclareMathSymbol{\curlyeqsucc} {3}{mathb}{"B7}
\DeclareMathSymbol{\ncurlyeqprec}{3}{mathb}{"B8}
\DeclareMathSymbol{\ncurlyeqsucc}{3}{mathb}{"B9}
%
\DeclareMathSymbol{\precsim}     {3}{mathb}{"C0}
\DeclareMathSymbol{\succsim}     {3}{mathb}{"C1}
\DeclareMathSymbol{\nprecsim}    {3}{mathb}{"C2}
\DeclareMathSymbol{\nsuccsim}    {3}{mathb}{"C3}
\DeclareMathSymbol{\precnsim}    {3}{mathb}{"C4}
\DeclareMathSymbol{\succnsim}    {3}{mathb}{"C5}
\DeclareMathSymbol{\precapprox}  {3}{mathb}{"C6}
\DeclareMathSymbol{\succapprox}  {3}{mathb}{"C7}
\DeclareMathSymbol{\nprecapprox} {3}{mathb}{"C8}
\DeclareMathSymbol{\nsuccapprox} {3}{mathb}{"C9}
\DeclareMathSymbol{\precnapprox} {3}{mathb}{"CA}
\DeclareMathSymbol{\succnapprox} {3}{mathb}{"CB}
%
\DeclareMathSymbol{\llcurly}     {3}{mathb}{"CE}
\DeclareMathSymbol{\ggcurly}     {3}{mathb}{"CF}
%
% \DeclareMathSymbol{\leftthreetimes} {3}{mathb}{"56}
% \DeclareMathSymbol{\rightthreetimes}{3}{mathb}{"57}
\end@mathabx
%
\mathabx@matha
\symbol@message{Arrows and harppons (matha)}
%
\DeclareMathSymbol{\leftarrow}             {3}{matha}{"D0}
	\mathabx@aliases\leftarrow\gets
\DeclareMathSymbol{\rightarrow}            {3}{matha}{"D1}
	\mathabx@aliases\rightarrow\to
% \DeclareMathSymbol{\uparrow}             {3}{matha}{"D2}
% \DeclareMathSymbol{\downarrow}           {3}{matha}{"D3}
\DeclareMathSymbol{\nwarrow}               {3}{matha}{"D4}
\DeclareMathSymbol{\nearrow}               {3}{matha}{"D5}
\DeclareMathSymbol{\swarrow}               {3}{matha}{"D6}
\DeclareMathSymbol{\searrow}               {3}{matha}{"D7}
\DeclareMathSymbol{\leftrightarrow}        {3}{matha}{"D8}
% \DeclareMathSymbol{\updownarrow}         {3}{matha}{"D9}
\DeclareMathSymbol{\nleftarrow}            {3}{matha}{"DA}
\DeclareMathSymbol{\nrightarrow}           {3}{matha}{"DB}
\DeclareMathSymbol{\nleftrightarrow}       {3}{matha}{"DC}
\mathabx@undefine{\relbar}
\DeclareMathSymbol{\relbar}                {3}{matha}{"DD}
\DeclareMathSymbol{\mapstochar}            {3}{matha}{"DE}
\DeclareMathSymbol{\mapsfromchar}          {3}{matha}{"DF}
%
\DeclareMathSymbol{\leftharpoonup}         {3}{matha}{"E0}
\DeclareMathSymbol{\rightharpoonup}        {3}{matha}{"E1}
\DeclareMathSymbol{\leftharpoondown}       {3}{matha}{"E2}
\DeclareMathSymbol{\rightharpoondown}      {3}{matha}{"E3}
\DeclareMathSymbol{\upharpoonleft}         {3}{matha}{"E4}
\DeclareMathSymbol{\downharpoonleft}       {3}{matha}{"E5}
\DeclareMathSymbol{\upharpoonright}        {3}{matha}{"E6}
\DeclareMathSymbol{\restriction}           {0}{matha}{"E6}
\DeclareMathSymbol{\downharpoonright}      {3}{matha}{"E7}
\DeclareMathSymbol{\leftrightharpoons}     {3}{matha}{"E8}
\mathabx@undefine{\rightleftharpoons}
\DeclareMathSymbol{\rightleftharpoons}     {3}{matha}{"E9}
\DeclareMathSymbol{\updownharpoons}        {3}{matha}{"EA}
\DeclareMathSymbol{\downupharpoons}        {3}{matha}{"EB}
%
\DeclareMathSymbol{\Leftarrow}             {3}{matha}{"F0}
\DeclareMathSymbol{\Rightarrow}            {3}{matha}{"F1}
% \DeclareMathSymbol{\Uparrow}             {3}{matha}{"F2}
% \DeclareMathSymbol{\Downarrow}           {3}{matha}{"F3}
\DeclareMathSymbol{\Leftrightarrow}        {3}{matha}{"F4}
% \DeclareMathSymbol{\Updownarrow}         {3}{matha}{"F5}
\DeclareMathSymbol{\nLeftarrow}            {3}{matha}{"F6}
\DeclareMathSymbol{\nRightarrow}           {3}{matha}{"F7}
\DeclareMathSymbol{\nLeftrightarrow}       {3}{matha}{"F8}
\mathabx@undefine{\Relbar}
\DeclareMathSymbol{\Relbar}                {3}{matha}{"F9}
\DeclareMathSymbol{\Mapstochar}            {3}{matha}{"FA}
\DeclareMathSymbol{\Mapsfromchar}          {3}{matha}{"FB}
\end@mathabx
%
\mathabx@mathb
\symbol@message{Arrows and harpoons (mathb)}
%
\DeclareMathSymbol{\leftleftarrows}        {3}{mathb}{"D0}
\DeclareMathSymbol{\rightrightarrows}      {3}{mathb}{"D1}
\DeclareMathSymbol{\upuparrows}            {3}{mathb}{"D2}
\DeclareMathSymbol{\downdownarrows}        {3}{mathb}{"D3}
\DeclareMathSymbol{\leftrightarrows}       {3}{mathb}{"D4}
\DeclareMathSymbol{\rightleftarrows}       {3}{mathb}{"D5}
\DeclareMathSymbol{\updownarrows}          {3}{mathb}{"D6}
\DeclareMathSymbol{\downuparrows}          {3}{mathb}{"D7}
\DeclareMathSymbol{\leftleftharpoons}      {3}{mathb}{"D8}
\DeclareMathSymbol{\rightrightharpoons}    {3}{mathb}{"D9}
\DeclareMathSymbol{\upupharpoons}          {3}{mathb}{"DA}
\DeclareMathSymbol{\downdownharpoons}      {3}{mathb}{"DB}
\DeclareMathSymbol{\leftbarharpoon}        {3}{mathb}{"DC}
\DeclareMathSymbol{\rightbarharpoon}       {3}{mathb}{"DD}
\DeclareMathSymbol{\barleftharpoon}        {3}{mathb}{"DE}
\DeclareMathSymbol{\barrightharpoon}       {3}{mathb}{"DF}
\DeclareMathSymbol{\leftrightharpoon}      {3}{mathb}{"E0}
\DeclareMathSymbol{\rightleftharpoon}      {3}{mathb}{"E1}
%
\DeclareMathSymbol{\rhook}                 {3}{mathb}{"E2}
\DeclareMathSymbol{\lhook}                 {3}{mathb}{"E3}
\DeclareMathSymbol{\diagup}                {3}{mathb}{"E4}
\DeclareMathSymbol{\diagdown}              {3}{mathb}{"E5}
%
\DeclareMathSymbol{\Lsh}                   {3}{mathb}{"E8}
	\mathabx@aliases\Lsh\ulsh
\DeclareMathSymbol{\Rsh}                   {3}{mathb}{"E9}
	\mathabx@aliases\Rsh\ursh
\DeclareMathSymbol{\dlsh}                  {3}{mathb}{"EA}
\DeclareMathSymbol{\drsh}                  {3}{mathb}{"EB}
%
\DeclareMathSymbol{\looparrowleft}         {3}{mathb}{"EC}
	\mathabx@aliases\looparrowleft\looparrowupleft
\DeclareMathSymbol{\looparrowright}        {3}{mathb}{"ED}
        \mathabx@aliases\looparrowright\looparrowupright
\DeclareMathSymbol{\looparrowdownleft}     {3}{mathb}{"EE}
\DeclareMathSymbol{\looparrowdownright}    {3}{mathb}{"EF}
%
\DeclareMathSymbol{\curvearrowleft}        {3}{mathb}{"F0}
	\mathabx@aliases\curvearrowleft\curvearrowtopleft
\DeclareMathSymbol{\curvearrowright}       {3}{mathb}{"F1}
        \mathabx@aliases\curvearrowright\curvearrowtopright
\DeclareMathSymbol{\curvearrowleftright}   {3}{mathb}{"F2}
        \mathabx@aliases\curvearrowleftright\curvearrowtopleftright
\DeclareMathSymbol{\curvearrowbotleft}     {3}{mathb}{"F3}
\DeclareMathSymbol{\curvearrowbotright}    {3}{mathb}{"F4}
\DeclareMathSymbol{\curvearrowbotleftright}{3}{mathb}{"F5}
%
\DeclareMathSymbol{\circlearrowleft}       {3}{mathb}{"F6}
\DeclareMathSymbol{\circlearrowright}      {3}{mathb}{"F7}
%
\DeclareMathSymbol{\leftsquigarrow}        {3}{mathb}{"F8}
\DeclareMathSymbol{\rightsquigarrow}       {3}{mathb}{"F9}
\DeclareMathSymbol{\leftrightsquigarrow}   {3}{mathb}{"FA}
%\DeclareMathSymbol{????????}              {3}{mathb}{"FB}
%
\DeclareMathSymbol{\lefttorightarrow}      {3}{mathb}{"FC}
\DeclareMathSymbol{\righttoleftarrow}      {3}{mathb}{"FD}
\DeclareMathSymbol{\uptodownarrow}         {3}{mathb}{"FE}
\DeclareMathSymbol{\downtouparrow}         {3}{mathb}{"FF}
\end@mathabx
%
\mathabx@matha
\symbol@message{Circles (matha)}
%
\DeclareMathSymbol{\oplus}        {2}{matha}{"60}
\DeclareMathSymbol{\ominus}       {2}{matha}{"61}
	\mathabx@aliases\ominus\circleddash
\DeclareMathSymbol{\otimes}       {2}{matha}{"62}
\DeclareMathSymbol{\odiv}         {2}{matha}{"63}
\DeclareMathSymbol{\odot}         {2}{matha}{"64}
\DeclareMathSymbol{\ocirc}        {2}{matha}{"65}
	\mathabx@aliases\ocirc\circledcirc
\DeclareMathSymbol{\oasterisk}    {2}{matha}{"66}
	\mathabx@aliases\oasterisk\circledast
\DeclareMathSymbol{\ocoasterisk}  {2}{matha}{"67}
\DeclareMathSymbol{\oleft}        {2}{matha}{"68}
\DeclareMathSymbol{\oright}       {2}{matha}{"69}
\DeclareMathSymbol{\otop}         {2}{matha}{"6A}
\DeclareMathSymbol{\obot}         {2}{matha}{"6B}
	\mathabx@aliases\obot\operp
\DeclareMathSymbol{\ovoid}        {2}{matha}{"6C}
\DeclareMathSymbol{\oslash}       {2}{matha}{"6D}
\DeclareMathSymbol{\obackslash}   {2}{matha}{"6E}
\DeclareMathSymbol{\otriangleup}  {2}{matha}{"6F}
\end@mathabx
%
\mathabx@mathb
\symbol@message{Boxes (mathb)}
%
\DeclareMathSymbol{\boxplus}      {2}{mathb}{"60}
\DeclareMathSymbol{\boxminus}     {2}{mathb}{"61}
	\mathabx@aliases\boxminus\boxeddash
\DeclareMathSymbol{\boxtimes}     {2}{mathb}{"62}
\DeclareMathSymbol{\boxdiv}       {2}{mathb}{"63}
\DeclareMathSymbol{\boxdot}       {2}{mathb}{"64}
\DeclareMathSymbol{\boxcirc}      {2}{mathb}{"65}
	\mathabx@aliases\boxcirc\boxedcirc
\DeclareMathSymbol{\boxasterisk}  {2}{mathb}{"66}
	\mathabx@aliases\boxasterisk\boxedast
\DeclareMathSymbol{\boxcoasterisk}{2}{mathb}{"67}
\DeclareMathSymbol{\boxleft}      {2}{mathb}{"68}
\DeclareMathSymbol{\boxright}     {2}{mathb}{"69}
\DeclareMathSymbol{\boxtop}       {2}{mathb}{"6A}
\DeclareMathSymbol{\boxbot}       {2}{mathb}{"6B}
	\mathabx@aliases\boxbot\boxperp
\DeclareMathSymbol{\boxvoid}      {2}{mathb}{"6C}
\mathabx@undefine{\Box}
\DeclareMathSymbol{\Box}          {0}{mathb}{"6C}
\DeclareMathSymbol{\boxslash}     {2}{mathb}{"6D}
\DeclareMathSymbol{\boxbackslash} {2}{mathb}{"6E}
\DeclareMathSymbol{\boxtriangleup}{2}{mathb}{"6F}
%
\symbol@message{Mayan numerals $\mathbfont 0\ 1\ 2\ 3\ 4\ 5$.}%
%
\newcount\mayacnter%
\newcount\mayacnta%
\newcount\mayacntb%
\newcount\mayacntc%
\newdimen\mayawidth%
%
\def\mayaexpansion{%
	\mayacntc=\mayacnta\mathbfont
	\ifnum\mayacntc=0 0\else
	\loop\ifnum\mayacntc>5\advance\mayacntc by -5\repeat
	\the\mayacntc\mayacntc=\mayacnta
	\loop\ifnum\mayacntc>5\advance\mayacntc by -5 5\repeat
	\fi}%
\def\mayarecurse{{%
	\mayacnta=\mayacnter \divide\mayacnter by 20
	\ifnum\mayacnter>0\mayarecurse\fi
	\mayacntb=\mayacnter 
	\multiply\mayacntb by-20
	\advance\mayacnta by\mayacntb
	\hbox to\mayawidth{\hss\mayaexpansion\hss}}}%
%
\def\maya#1{%
	\mayacnter=#1
	\setbox0\hbox{\mathbfont 0}%
	\mayawidth=\wd0
	\left\mayaleftdelimiter
	\vcenter{\mayarecurse}
	\right\mayarightdelimiter}%
\def\mayadigit#1{%
	\mayacnta=#1\hbox{\mathbfont\mayaexpansion}}%
\def\mayadelimiters(#1,#2){%
	\let\mayaleftdelimiter=#1
	\let\mayarightdelimiter=#2}%
\mayadelimiters(|,|)%
\end@mathabx%
%
\mathabx@mathx%
\symbol@message{Large operators (mathx)}
%
\mathabx@undefine{\sum}
\DeclareMathSymbol{\sum}    {1}{mathx}{"B0}
\mathabx@undefine{\prod}
\DeclareMathSymbol{\prod}   {1}{mathx}{"B1}
\mathabx@undefine{\coprod}
\DeclareMathSymbol{\coprod} {1}{mathx}{"B2}
\DeclareMathSymbol{\intop}  {1}{mathx}{"B3}
\DeclareMathSymbol{\iintop} {1}{mathx}{"B4}
%\def\iintop{\intop\mkern-6mu\intop}
	\mathabx@aliases\iintop\iint
\DeclareMathSymbol{\iiintop}{1}{mathx}{"B5}
%\def\iiintop{\intop\mkern-6mu\intop\mkern-6mu\intop}
	\mathabx@aliases\iiintop\iiint
\DeclareMathSymbol{\ointop} {1}{mathx}{"B6}
	\mathabx@aliases\ointop\oint
\DeclareMathSymbol{\oiintop}{1}{mathx}{"B7}
	\mathabx@aliases\oiintop\oiint
\def\int{\intop\nolimits}%
% look yourself for \nolimits...
\DeclareMathSymbol{\bigplus}        {1}{mathx}{"90}
\DeclareMathSymbol{\bigtimes}       {1}{mathx}{"91}
\DeclareMathSymbol{\bigcomplementop}{1}{mathx}{"92}%
\def\bigcomplement{\bigcomplementop\nolimits}%
%\DeclareMathSymbol{\bigtruc}        {1}{mathx}{"93}
%\DeclareMathSymbol{\bigcurt}        {1}{mathx}{"94}
\mathabx@undefine{\bigcap}%
\DeclareMathSymbol{\bigcap}         {1}{mathx}{"93}
\mathabx@undefine{\bigcup}
\DeclareMathSymbol{\bigcup}         {1}{mathx}{"94}
\mathabx@undefine{\biguplus}
\DeclareMathSymbol{\biguplus}       {1}{mathx}{"95}
\mathabx@undefine{\bigsqcap}
\DeclareMathSymbol{\bigsqcap}       {1}{mathx}{"96}
\mathabx@undefine{\bigsqcup}
\DeclareMathSymbol{\bigsqcup}       {1}{mathx}{"97}
\DeclareMathSymbol{\bigsquplus}     {1}{mathx}{"98}
\mathabx@undefine{\bigwedge}
\DeclareMathSymbol{\bigwedge}       {1}{mathx}{"99}
\mathabx@undefine{\bigvee}
\DeclareMathSymbol{\bigvee}         {1}{mathx}{"9A}
\DeclareMathSymbol{\bigcurlywedge}  {1}{mathx}{"9B}
\DeclareMathSymbol{\bigcurlyvee}    {1}{mathx}{"9C}
%
\symbol@message{Big circles (mathx)}
%
\mathabx@undefine{\bigoplus}
\DeclareMathSymbol{\bigoplus}      {1}{mathx}{"C0}
\DeclareMathSymbol{\bigominus}     {1}{mathx}{"C1}
\mathabx@undefine{\bigotimes}
\DeclareMathSymbol{\bigotimes}     {1}{mathx}{"C2}
\DeclareMathSymbol{\bigodiv}       {1}{mathx}{"C3}
\mathabx@undefine{\bigodot}
\DeclareMathSymbol{\bigodot}       {1}{mathx}{"C4}
\DeclareMathSymbol{\bigocirc}      {1}{mathx}{"C5}
\DeclareMathSymbol{\bigoasterisk}  {1}{mathx}{"C6}
\DeclareMathSymbol{\bigocoasterisk}{1}{mathx}{"C7}
\DeclareMathSymbol{\bigoleft}      {1}{mathx}{"C8}
\DeclareMathSymbol{\bigoright}     {1}{mathx}{"C9}
\DeclareMathSymbol{\bigotop}       {1}{mathx}{"CA}
\DeclareMathSymbol{\bigobot}       {1}{mathx}{"CB}
	\mathabx@aliases\bigotop\bigoperp
\DeclareMathSymbol{\bigovoid}      {1}{mathx}{"CC}
\DeclareMathSymbol{\bigoslash}     {1}{mathx}{"CD}
\DeclareMathSymbol{\bigobackslash} {1}{mathx}{"CE}
\DeclareMathSymbol{\bigotriangleup}{1}{mathx}{"CF}
%
\symbol@message{Big boxes (mathx)}
%
\DeclareMathSymbol{\bigboxplus}      {1}{mathx}{"D0}
\DeclareMathSymbol{\bigboxminus}     {1}{mathx}{"D1}
\DeclareMathSymbol{\bigboxtimes}     {1}{mathx}{"D2}
\DeclareMathSymbol{\bigboxdiv}       {1}{mathx}{"D3}
\DeclareMathSymbol{\bigboxdot}       {1}{mathx}{"D4}
\DeclareMathSymbol{\bigboxcirc}      {1}{mathx}{"D5}
\DeclareMathSymbol{\bigboxasterisk}  {1}{mathx}{"D6}
\DeclareMathSymbol{\bigboxcoasterisk}{1}{mathx}{"D7}
\DeclareMathSymbol{\bigboxleft}      {1}{mathx}{"D8}
\DeclareMathSymbol{\bigboxright}     {1}{mathx}{"D9}
\DeclareMathSymbol{\bigboxtop}       {1}{mathx}{"DA}
\DeclareMathSymbol{\bigboxbot}       {1}{mathx}{"DB}
	\mathabx@aliases\bigboxbot\bigboxperp
\DeclareMathSymbol{\bigboxvoid}      {1}{mathx}{"DC}
\DeclareMathSymbol{\bigboxslash}     {1}{mathx}{"DD}
\DeclareMathSymbol{\bigboxbackslash} {1}{mathx}{"DE}
\DeclareMathSymbol{\bigboxtriangleup}{1}{mathx}{"DF}
\end@mathabx
%
\mathabx@matha
\mathabx@mathx
\symbol@message{Delimiters (matha/mathx)}
%
\DeclareMathDelimiter{(}              {matha}{"70}{mathx}{"00}
\DeclareMathDelimiter{)}              {matha}{"71}{mathx}{"08}
\DeclareMathDelimiter{[}              {matha}{"72}{mathx}{"10}
\DeclareMathDelimiter{]}              {matha}{"73}{mathx}{"18}
\DeclareMathDelimiter{\lbrace}     {4}{matha}{"74}{mathx}{"20}
\ifx\@latexbug\undefined
	\mathabx@aliases\lbrace\{
\else% suggested by Patrick Cousot
	\DeclareRobustCommand{\{}{\ifmmode\lbrace\else\textbraceleft\fi}
\fi
\DeclareMathDelimiter{\rbrace}     {5}{matha}{"75}{mathx}{"28}
\ifx\@latexbug\undefined
	\mathabx@aliases\rbrace\}
\else
	\DeclareRobustCommand{\}}{\ifmmode\rbrace\else\textbraceright\fi}
\fi
\DeclareMathDelimiter{\ldbrack}   {4}{matha}{"76}{mathx}{"30}
	\mathabx@aliases\ldbrack\lsemantic
\DeclareMathDelimiter{\rdbrack}   {5}{matha}{"77}{mathx}{"38}
	\mathabx@aliases\rdbrack\rsemantic
\DeclareMathDelimiter{\langle}     {4}{matha}{"78}{mathx}{"40}
\DeclareMathDelimiter{\rangle}     {5}{matha}{"79}{mathx}{"44}
\mathabx@undefine{\backslash}
\DeclareMathDelimiter{\backslash}  {0}{matha}{"7A}{mathx}{"48}
\DeclareMathDelimiter{/}              {matha}{"7B}{mathx}{"4C}
\DeclareMathDelimiter{\vert}       {0}{matha}{"7C}{mathx}{"07}
\DeclareMathDelimiter{|}              {matha}{"7C}{mathx}{"07}
\DeclareMathDelimiter{\Vert}       {0}{matha}{"7D}{mathx}{"0F}
\DeclareMathDelimiter{\vvvert}     {0}{matha}{"7E}{mathx}{"17}
	\mathabx@aliases\Vert\|
\DeclareMathDelimiter{\uparrow}    {3}{matha}{"D2}{mathx}{"9D}
\DeclareMathDelimiter{\downarrow}  {3}{matha}{"D3}{mathx}{"9E}
\DeclareMathDelimiter{\updownarrow}{3}{matha}{"D9}{mathx}{"9F}
\DeclareMathDelimiter{\Uparrow}    {3}{matha}{"F2}{mathx}{"AD}
\DeclareMathDelimiter{\Downarrow}  {3}{matha}{"F3}{mathx}{"AE}
\DeclareMathDelimiter{\Updownarrow}{3}{matha}{"F5}{mathx}{"AF}
\end@mathabx
\end@mathabx
\mathabx@mathb
\mathabx@mathx
\symbol@message{Delimiters (mathb/mathx)}
%
\DeclareMathDelimiter{\lgroup}     {4}{mathb}{"70}{mathx}{"76}% fully supp.
\DeclareMathDelimiter{\rgroup}     {5}{mathb}{"71}{mathx}{"77}% fully supp.
\DeclareMathDelimiter{\lceil}      {4}{mathb}{"72}{mathx}{"50}
\DeclareMathDelimiter{\rceil}      {5}{mathb}{"73}{mathx}{"54}
\DeclareMathDelimiter{\lfloor}     {4}{mathb}{"74}{mathx}{"58}
\DeclareMathDelimiter{\rfloor}     {5}{mathb}{"75}{mathx}{"5C}
\DeclareMathDelimiter{\thickvert}  {0}{mathb}{"7E}{mathx}{"1F}
\end@mathabx
\end@mathabx
%
\mathabx@mathx
\symbol@message{Delimiters (mathx/mathx)}
%
\DeclareMathDelimiter{\lfilet}     {4}{mathx}{"37}{mathx}{"37}
\DeclareMathDelimiter{\rfilet}     {5}{mathx}{"3F}{mathx}{"3F}
%
%\DeclareMathDelimiter{\lmoustache}{4}{mathx}{"05}{mathx}{"05}% not supp.
%\DeclareMathDelimiter{\rmoustache}{5}{mathx}{"0D}{mathx}{"0D}% not supp.
\end@mathabx
%
\mathabx@mathx
\symbol@message{Pieces for over-under-braces and such (mathx)}
%
\DeclareMathSymbol{\braceld}       {0}{mathx}{"68}
\DeclareMathSymbol{\bracemd}       {0}{mathx}{"69}
\DeclareMathSymbol{\bracerd}       {0}{mathx}{"6A}
\DeclareMathSymbol{\bracexd}       {0}{mathx}{"6B}
\DeclareMathSymbol{\bracelu}       {0}{mathx}{"6C}
\DeclareMathSymbol{\bracemu}       {0}{mathx}{"6D}
\DeclareMathSymbol{\braceru}       {0}{mathx}{"6E}
\DeclareMathSymbol{\bracexu}       {0}{mathx}{"6F}
%
% Borrowed from "newmath" by Matthias Clasen and Ulrik Vieth.
%
\def\braceexwd{2mu}%
\def\bracevkern{0pt}%
%
% Remark: it seems that new horizontal braces may take
% into account vertical skip in their native design.
% We've followed this idea and not Knuth's construction.
% But we can add or sustract \bracevkern.
%
\def\bracefill#1#2#3#4{$\m@th
	#1#4\mkern-\braceexwd \cleaders\hbox{$#4$}\hfill
	\mkern-\braceexwd#4#2#4\mkern-\braceexwd
	\cleaders\hbox{$#4$}\hfill \mkern-\braceexwd#4#3$}%
%
\def\overbrace@#1#2{\mathop{\vbox{\m@th\ialign{##\crcr
	\noalign{\kern\bracevkern}
	#1\crcr\noalign{\kern\bracevkern\nointerlineskip}%
	$\hfil\displaystyle{#2}\hfil$\crcr}}}\limits}%
%
\def\underbrace@#1#2{\mathop{\vtop{\m@th\ialign{##\crcr
	$\hfil\displaystyle{#2}\hfil$\crcr
	\noalign{\kern\bracevkern\nointerlineskip}
	#1\crcr\noalign{\kern\bracevkern}}}}\limits}%
% user-level macros
\def\overbrace{\overbrace@{\bracefill\braceld\bracemd\bracerd\bracexd}}
\def\underbrace{\underbrace@{\bracefill\bracelu\bracemu\braceru\bracexu}}
\def\overgroup{\overbrace@{\bracefill\braceld{}\bracerd\bracexd}}
\def\undergroup{\underbrace@{\bracefill\bracelu{}\braceru\bracexu}}
%
\symbol@message{Extensible accents (mathx)}
%
\DeclareMathAccent{\widehat}      {0}{mathx}{"70}
\DeclareMathAccent{\widecheck}    {0}{mathx}{"71}
\DeclareMathAccent{\widetilde}    {0}{mathx}{"72}
\DeclareMathAccent{\widebar}      {0}{mathx}{"73}
\DeclareMathAccent{\widearrow}    {0}{mathx}{"74}
\DeclareMathAccent{\wideparen}    {0}{mathx}{"75}
	\def\widering#1{\ring{\wideparen{#1}}}%
	\def\widedot#1{\dot{\wideparen{#1}}}%
	\def\wideddot#1{\ddot{\wideparen{#1}}}%
	\def\widedddot#1{\dddot{\wideparen{#1}}}%
	\def\wideddddot#1{\ddddot{\wideparen{#1}}}%
\edef\surd{{\noexpand\mathchar"1\expandafter\hexnumber@
	\ifx\@latexbug\undefined\mathxfam\else\symmathx\fi60}}%
\ifx\@latexbug\undefined
	\ifx\mathabx@matha\relax
		\DeclareMathRadical{\sqrt}{matha}{"3F}{mathx}{"61}
	\else
		\DeclareMathRadical{\sqrt}{mathx}{"60}{mathx}{"61}
	\fi
\else% suggested by Kohsaku Hotta
	\mathabx@undefine{\sqrtsign}
	\ifx\mathabx@matha\relax
		\DeclareMathRadical{\sqrtsign}{matha}{"3F}{mathx}{"61}
	\else
		\DeclareMathRadical{\sqrtsign}{mathx}{"60}{mathx}{"61}
	\fi
\fi
\end@mathabx
%
%
% the \not construction
%
\long\def\@gobble#1{}
%
\def\not#1{%
\let\@@not=\not \let\@@n=\n \let\not=\relax \let\n=\relax
\expandafter\ifx\csname not\expandafter\@gobble\string#1\endcsname\relax%
\expandafter\ifx\csname n\expandafter\@gobble\string#1\endcsname\relax%
\notsign#1%
\else\csname n\expandafter\@gobble\string#1\endcsname\fi
\else\csname not\expandafter\@gobble\string#1\endcsname\fi
\let\not=\@@not \let\n=\@@n}
%
\ifx\mathabx@mathb\mathabx@skip
	\let\varnot=\not
	\let\changenotsign=\relax
\else
	\def\varnot#1{%
		\let\@@not=\varnot\let\varnot=\relax
		\expandafter
		\ifx
		\csname varnot\expandafter\@gobble\string#1\endcsname
		\relax%
		\varnotsign#1%
		\else
		\csname varnot\expandafter\@gobble\string#1\endcsname
		\fi
		\let\varnot=\@@not}
	\def\changenotsign{%
		\let\@@not=\notsign
		\let\notsign=\varnotsign
		\let\varnotsign=\@@not}
\fi

\def\mathabx@anyfill#1#2#3{$\m@th
	\ifx#1\relax\relax\smash#2\mkern-7mu\else\mathord#1\mkern-7mu\fi
	\cleaders\hbox{$\mkern-2mu\smash#2\mkern-2mu$}\hfill
	\ifx#3\relax\relax\mkern-7mu\smash#2\else\mkern-7mu\mathord#3\fi$}

\def\mathabx@overfill#1#2#3#4#5{\vbox{\m@th\ialign{##\crcr
	\mathabx@anyfill{#2}{#3}{#4}\crcr
	\noalign{\kern#1\nointerlineskip}%
	$\hfil\displaystyle{#5}\hfil$\crcr}}}%
\def\mathabx@underfill#1#2#3#4#5{\vtop{\m@th\ialign{##\crcr
	$\hfil\displaystyle{#5}\hfil$\crcr
	\noalign{\kern#1\nointerlineskip}%
	\mathabx@anyfill{#2}{#3}{#4}\crcr}}}%

\def\overrightarrow{\mathabx@overfill{-\p@}{}\relbar\rightarrow}%
\def\overleftarrow{\mathabx@overfill{-\p@}\leftarrow\relbar{}}%
\def\overleftrightarrow{\mathabx@overfill{-\p@}\leftarrow\relbar\rightarrow}%
\def\underrightarrow{\mathabx@underfill{\p@}{}\relbar\rightarrow}%
\def\underleftarrow{\mathabx@underfill{\p@}\leftarrow\relbar{}}%
\def\underleftrightarrow{\mathabx@underfill{\p@}\leftarrow\relbar\rightarrow}%
\def\overRightarrow{\mathabx@overfill{-.5\p@}{}\Relbar\Rightarrow}%
\def\overLeftarrow{\mathabx@overfill{-.5\p@}\Leftarrow\Relbar{}}%
\def\overLeftRightarrow{\mathabx@overfill{-.5\p@}\Leftarrow\Relbar\Rightarrow}%
\def\underRightarrow{\mathabx@underfill{\p@}{}\Relbar\Rightarrow}%
\def\underLeftarrow{\mathabx@underfill{\p@}\Leftarrow\Relbar{}}%
\def\underLeftRightarrow{\mathabx@underfill{\p@}\Leftarrow\Relbar\Rightarrow}%
%
%\symbol@message{\centerline{---~Leaving mathabx.tex~---}}
%
\catcode`@=12
\endinput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% UNAVAILABLE
%
%\symbol@message{Small things ???}
%
\DeclareMathSymbol{\smallsum}{0}{mathx}{"40}
\DeclareMathSymbol{\smallprod}{0}{mathx}{"41}
\DeclareMathSymbol{\smallcoprod}{0}{mathx}{"42}
\DeclareMathSymbol{\complement}{0}{mathx}{"43}
\DeclareMathSymbol{\boldcomplement}{0}{mathx}{"44}
\DeclareMathSymbol{\boldcup}{2}{mathx}{"45}
\DeclareMathSymbol{\boldcap}{2}{mathx}{"46}
\DeclareMathSymbol{\boldZ}{0}{mathx}{"47}
\DeclareMathSymbol{\bigboldZ}{1}{mathx}{"4A}
%
%\symbol@message{Inequalities (mathbb) unsupported}
%
%\DeclareMathSymbol{\preceqq}{3}{mathb}{"AE}
%\DeclareMathSymbol{\succeqq}{3}{mathb}{"AF}
%\DeclareMathSymbol{\notpreceqq}{3}{mathb}{"B0}
%	\let\@notpreceqq=!
%	\let\npreceqq=\notpreceqq
%\DeclareMathSymbol{\notsucceqq}{3}{mathb}{"B1}
%	\let\@notqeqq=!
%	\let\nsucceqq=\notsucceqq
%\DeclareMathSymbol{\precneqq}{3}{mathb}{"B2}
%\DeclareMathSymbol{\succneqq}{3}{mathb}{"B3}
%\DeclareMathSymbol{\precvertneqq}{3}{mathb}{"B4}
%\DeclareMathSymbol{\succvertneqq}{3}{mathb}{"B5}
%\DeclareMathSymbol{\precsucc}{3}{mathb}{"B2}
%\DeclareMathSymbol{\succprec}{3}{mathb}{"B3}
%\DeclareMathSymbol{\preceqsucc}{3}{mathb}{"B4}
%\DeclareMathSymbol{\succeqprec}{3}{mathb}{"B5}
%\DeclareMathSymbol{\preceqqsucc}{3}{mathb}{"B6}
%\DeclareMathSymbol{\succeqqprec}{3}{mathb}{"B7}

%\DeclareMathSymbol{\upasterisk}{0}{matha}{}
%\DeclareMathSymbol{\lowasterisk}{0}{matha}{}
%\DeclareMathSymbol{\triasterisk}{0}{matha}{}
%
\symbol@message{Hebrew (matha/mathb)}
%
\DeclareMathSymbol{\aleph}{7}{matha}{"40}
\DeclareMathSymbol{\beth}{7}{matha}{"41}
\DeclareMathSymbol{\gimmel}{7}{matha}{"42}
\DeclareMathSymbol{\dalet}{7}{matha}{"43}
\DeclareMathSymbol{\he}{7}{matha}{"44}
\DeclareMathSymbol{\vav}{7}{matha}{"45}
\DeclareMathSymbol{\zayin}{7}{matha}{"46}
\DeclareMathSymbol{\het}{7}{matha}{"47}
\DeclareMathSymbol{\tet}{7}{matha}{"48}
\DeclareMathSymbol{\yod}{7}{matha}{"49}
\DeclareMathSymbol{\finalkaf}{7}{matha}{"4A}
\DeclareMathSymbol{\kaf}{7}{matha}{"4B}
\DeclareMathSymbol{\lamed}{7}{matha}{"4C}
\DeclareMathSymbol{\finalmem}{7}{matha}{"4D}
\DeclareMathSymbol{\mem}{7}{matha}{"4E}
\DeclareMathSymbol{\finalnun}{7}{matha}{"4F}
\DeclareMathSymbol{\nun}{7}{matha}{"50}
\DeclareMathSymbol{\samekh}{7}{matha}{"51}
\DeclareMathSymbol{\ayin}{7}{matha}{"52}
\DeclareMathSymbol{\finalpe}{7}{matha}{"53}
\DeclareMathSymbol{\pe}{7}{matha}{"54}
\DeclareMathSymbol{\finaltzadik}{7}{matha}{"55}
\DeclareMathSymbol{\tzadik}{7}{matha}{"56}
\DeclareMathSymbol{\qof}{7}{matha}{"57}
\DeclareMathSymbol{\resh}{7}{matha}{"58}
\DeclareMathSymbol{\shin}{7}{matha}{"59}
\DeclareMathSymbol{\tav}{7}{matha}{"5A}
%
% \DeclareMathSymbol{\Qinv}        {0}{matha}{"4A}
% \DeclareMathSymbol{\BourbarkiZ}  {0}{matha}{"4F}
%%%{\catcode`\°=\active \gdef°{^\degree}}
%%%\mathcode`\°="8000
%%% pas bon du tout, il faudrait pouvoir
%%% le melanger avec les '''
%
%
%\DeclareMathSymbol{\dottruc}       {2}{mathb}{"06}% name to be checked
%\DeclareMathSymbol{\dotcurt}       {2}{mathb}{"07}% name to be checked
\DeclareMathSymbol{\truc}          {2}{matha}{"06}
\DeclareMathSymbol{\curt}          {2}{matha}{"07}
