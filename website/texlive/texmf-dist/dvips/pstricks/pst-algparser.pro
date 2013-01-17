% $Id: pst-algparser.pro 594 2011-10-31 18:13:18Z herbert $
%%
%% PostScript prologue for PSTricks algorithm parser
%% Version 0.04, 2011/10/21
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%%-----------------------------------------------------------------------------%
%
/AlgParser { tx@AlgToPs begin AlgToPs end } def  % Dominique Rodriguez
%
/tx@CoreAnalyzerDict 100 dict def tx@CoreAnalyzerDict begin
%
% PS ANALYZER FOR ALGEBRAIC EXPRESSION V1.13
%
% 09/2011 DR factorial with ! added
%
% E->T|E+T
% T->FS|T*FS
% FS -> F | +FS | -FS
% F->P|F^SF|P!
% P->(E)|literal
% literal->number|var|var[E]|func(params)
% params->E|E,param
% number->TOBEFINISHED
%
%% E expression, T term, SF signed factor, F factor, P power
%
%% parser
%
%% str
%
%% C->E<condition_operators>E
%% STR index -> STR index+lenExpr
/AnalyzeCond { AnalyzeExpr ReadCondOp AnalyzeExpr EvalCondOp  } def
%
%% analyze Expression List (separator , or | )
%% STR index -> STR index+lenExpr
%% /AnalyzeListOfE {
%%   { NextNonBlankChar pop AnalyzeExpr%%dup Strlen eq { exit } if NextNonBlankChar
%%     NextNonBlankChar dup 0 eq { pop exit } if
%%     dup 44 ne 1 index 124 ne and { dup 41 ne { PROBLEMCONTACTBILLOU } { pop exit } ifelse } if
%%     pop NextNonBlankChar dup 0 eq { exit } if 124 ne { PROBLEMCONTACTBILLOU } if 1 add NextNonBlankChar 0 eq {toto} if } loop
%%   AnalyzeListOfEPostHook
%% } def
/AnalyzeListOfE {
  /NotFirst false def
  { NextNonBlankChar pop AnalyzeExpr
    NotFirst { EvalListOfExpr } { /NotFirst true def } ifelse
    dup Strlen eq { exit } if NextNonBlankChar
    dup 44 ne 1 index 124 ne and
    { dup 41 ne { PROBLEMCONTACTBILLOU } { pop exit } ifelse }
    if  pop 1 add } loop
  AnalyzeListOfEPostHook
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% E->T|E+T
%% STR index -> STR index+lenExpr
/AnalyzeExpr {
  AnalyzePreHook AnalyzeTerm IsEndingExpr
  { dup 0 ne { 32 eq { NextNonBlankChar } if } { pop } ifelse }
  { { RollOp 1 add NextNonBlankChar pop AnalyzeTerm PreEvalHook EvalAddSub IsEndingExpr { pop exit } if } loop }
  ifelse
  AnalyzePostHook
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% T->FS|T*FS
%% STR index
/AnalyzeTerm {
  AnalyzePreHook AnalyzeSignedFactor IsEndingTerm
  { dup 0 ne { 32 eq { NextNonBlankChar } if } { pop } ifelse }
  { { RollOp 1 add NextNonBlankChar pop AnalyzeSignedFactor PreEvalHook EvalMulDiv IsEndingTerm { pop exit } if} loop }
  ifelse
  AnalyzePostHook
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FS -> F | +FS | -FS
%% STR index
/AnalyzeSignedFactor {
  AnalyzePreHook 2 copy get dup IsUnaryOp
  { RollOp 1 add NextNonBlankChar pop AnalyzeSignedFactor EvalUnaryOp }
  { pop AnalyzeFactor }
  ifelse AnalyzePostHook
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% F->P|F^P|P!
%% STR index
/AnalyzeFactor {
  AnalyzePreHook AnalyzePower IsEndingFactor
  { dup 0 ne { 32 eq { NextNonBlankChar } if } { pop } ifelse }
  { { dup 33 eq%% is there a ! DR 09/2011
      { pop 1 add NextNonBlankChar pop EvalFactorial }
      { RollOp 1 add NextNonBlankChar pop AnalyzePower PreEvalHook EvalPower }
      ifelse
      IsEndingFactor { pop exit } if } loop }
  ifelse  AnalyzePostHook
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% P->(E)|literal
%% STR index
/AnalyzePower {
  %% depending of first char either a number, or a literal
  2 copy get dup 40 eq%%an open par
  { pop 1 add NextNonBlankChar pop AnalyzeExpr 1 add NextNonBlankChar pop }
  { AnalyzeLiteral }
  ifelse
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% STR index STR[index] -> STR index
%/AnalyzeLiteral { IsNumber { EvalNumber } { EvalLiteral } ifelse } def
/AnalyzeLiteral { dup IsUnaryOp exch IsNumber or { EvalNumber } { EvalLiteral } ifelse } def%%dr 09102006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% recognize + or -
%% chr -> T/F
/IsUnaryOp { dup 43 eq exch 45 eq or } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a number can contain only : 0123456789.
%% chr -> T/F
/IsNumber { dup 48 ge exch dup 57 le 3 -1 roll and exch 46 eq or } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% STR index -> STR index number
%% a number can be of the form [0-9]*.[0-9]*\([eE][+-]?[0-9]+\)?
%% STR index -> STR index' number
/ReadNumber {
  exch dup 3 -1 roll dup 3 1 roll
  %%read mantissa
  { 1 add  2 copy dup Strlen eq { pop pop 0 exit } if get dup IsNumber not { exit } if pop } loop
  dup 101 eq exch 69 eq or
  %%% there is a "e" or "E" -> read exponant
  { 1 add 2 copy get dup IsUnaryOp
    { pop 1 add 2 copy get } if
    { IsNumber not { exit } if 1 add 2 copy get } loop }
  if
  dup 4 1 roll
  3 -1 roll exch 1 index sub getinterval
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a number can contain only : 0123456789.
%% chr -> T/F
/IsCondOp { dup 30 eq exch dup 60 ge exch 62 le and or } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% STR index -> STR index number
%% a number can be of the form [0-9]*.[0-9]*\([eE][+-]?[0-9]+\)?
%% STR index -> STR index' number
/ReadCondOp {
  NextNonBlankChar 1 index 4 1 roll
  { IsCondOp not { exit } if 1 add  2 copy get } loop
  2 copy 5 -1 roll
  exch 1 index sub getinterval 3 1 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a literal can contain only : 0123456789.
%% chr -> T/F
/IsLiteral {%
  dup 48 ge exch dup  57 le 3 -1 roll and exch
  dup 65 ge exch dup  90 le 3 -1 roll and 3 -1 roll or exch
  dup 97 ge exch     122 le and or } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a literal can be of the form [a-zA-Z][a-zA-Z0-9]*\(\((Expression)\)|\(\[Expression\]\)\)?
%% STR index -> literal STR index' nextchr
/ReadLiteral {
  exch dup 3 -1 roll dup 3 1 roll
  %%read literal core
  { 2 copy dup Strlen eq { pop pop 0 exit } if get dup IsLiteral not { exit } if pop 1 add } loop
  4 1 roll dup 5 1 roll 3 -1 roll exch 1 index sub getinterval 4 1 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% expr is ended by end of str or a clpar
%% STR index -> STR index STR[index] T/F
/IsEndingExpr {%
  2 copy dup Strlen eq
  %% if end of str is reached -> end !
  { pop pop 0 true }
  %% ending chr -> clpar, comma, |, <, >, =, !,
  {get dup  dup  41 eq
       exch dup 124 eq
       exch dup  93 eq
       exch dup  44 eq
       exch dup  30 eq
       exch dup  60 ge exch 62 le and or or or or or}
  ifelse } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% expr is ended by end of str or a +-
%% STR index -> STR index STR[index] T/F
/IsEndingTerm { IsEndingExpr { true } { dup dup 43 eq exch 45 eq or } ifelse } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% expr is ended by end of str or */
%% STR index -> STR index STR[index] T/F
/IsEndingFactor { IsEndingTerm { true } { dup dup 42 eq exch 47 eq or } ifelse } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% expr is ended by end of str or ^
%% STR index -> STR index STR[index] T/F
/IsEndingPower { IsEndingFactor { true } { dup 94 eq } ifelse } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% STR index -> STR index STR[index]
/NextNonBlankChar { { dup Strlen eq { 0 exit } if 2 copy get dup neBlkChar { exit } if pop 1 add } loop } bind def
/neBlkChar { dup 32 ne exch dup 10 ne exch 9 ne and and } bind def
%%%%%%%%%%%%%%%%%%%%%%%%
%% DEBUG
/BRK {false} def
/BRKtrue {/BRK true def} def
/BRKStop {BRK {BRKtoto} if } def
/BRKEvalStop {BRK exch if } def
/BRKBRK2true {BRK {BRK2true} if } def
/BRK2 {false} def
/BRK2true {/BRK2 true def} def
/BRK2Stop {BRK2 {BRK2toto} if } def/BRK {false} def
end
%
%-------------------------------------------------------------------------------%
%
/tx@AlgToPs 12 dict def tx@AlgToPs begin
%
%% algExpr -> PSVector
/AlgToPs { tx@CoreAnalyzerDict begin InitParser AnalyzeListOfE pop pop EndingSequence end } def
/EndingSequence { ExpressionVector aload length /end cvx exch 1 add array astore } def
/InitParser { /ExpressionVector [ /tx@AddMathFunc cvx /begin cvx ] def dup length /Strlen exch def 0 } def
/Strlen 0 def
/EvalListOfExpr {} def%
/EvalNumber {%
    ReadNumber  cvr /ExpressionVector ExpressionVector aload length dup 3 add -1 roll cvx
    exch 1 add array astore def NextNonBlankChar pop } def
/EvalAddSub {%
  /ExpressionVector ExpressionVector aload length dup 5 add -1 roll
  43 eq { /add } { /sub } ifelse cvx exch 1 add array astore def
} def
/EvalMulDiv {%
  /ExpressionVector ExpressionVector aload length dup 5 add -1 roll
  42 eq { /mul } { /div } ifelse cvx exch 1 add array astore def
} def
/EvalPower {%
  /ExpressionVector ExpressionVector aload length dup 5 add -1 roll
  pop /exp cvx exch 1 add array astore def
} def
/EvalFactorial {% DR 09/2011
  /ExpressionVector ExpressionVector aload length
  /fact cvx exch 1 add array astore def
} def
/EvalLiteral {%
  ReadLiteral
  dup 40 eq%%% there is an open par -> function call
  { pop 2 index
    dup (Sum) eq { EvalSum }
    { dup (IfTE) eq { EvalCond }
      { dup (Derive) eq { pop EvalDerive }
	{ pop 1 add NextNonBlankChar pop AnalyzeListOfE 2 index TrigoFunc
          /ExpressionVector ExpressionVector aload length dup 5 add -1 roll cvn cvx
	  exch 1 add array astore def 1 add NextNonBlankChar pop } ifelse } ifelse} ifelse }
  { /ExpressionVector ExpressionVector aload length dup 6 add -1 roll cvn cvx exch 1 add array astore def
    dup 91 eq%%% there is an open bracket -> vector element
    { pop 1 add NextNonBlankChar pop AnalyzeExpr
      /ExpressionVector ExpressionVector aload length /cvi cvx exch /get cvx exch 2 add array astore def 1 add }
    { pop NextNonBlankChar pop }
    ifelse}
  ifelse
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% the derive function : Derive(n,f(x))
%% firstparindex lastparindex ->
/EvalDerive {
  %% manage the function descripiton
  1 add ReadNumber 3 1 roll NextNonBlankChar
  44 ne { ANALYZER_ERROR_missing_second_comma_in_Sum } if
  1 add NextNonBlankChar pop
  3 -1 roll cvi
  dup 0 eq
  { pop AnalyzeExpr 3 -1 roll pop 1 add }
  { 1 sub 3 1 roll (x)  exch tx@Derive begin DeriveIndexed end 4 -1 roll
    { (x) tx@Derive begin Derive end } repeat
    ExpressionVector exch /ExpressionVector [] def
    AlgToPs aload length
    /ExpressionVector 1 index 3 add -1 roll aload length dup 3 add -1 roll  /l2 exch def /l1 exch def
    l1 l2 add 1 add l2 neg roll l1 l2 add array astore def 3 -1 roll pop 1 add
    1 index length /Strlen exch def } ifelse
} def
/EvalSum {%
  pop 1 add NextNonBlankChar pop
  %% read the variable name
  ReadLiteral pop NextNonBlankChar
  44 ne { ANALYZER_ERROR_missing_first_comma_in_Sum } if
  %% read the initial value
  1 add NextNonBlankChar pop ReadNumber cvi 3 1 roll
  2 copy get 44 ne { ANALYZER_ERROR_missing_second_comma_in_Sum } if
  %% read the increment value
  1 add NextNonBlankChar pop ReadNumber cvi 3 1 roll
  2 copy get 44 ne { ANALYZER_ERROR_missing_second_comma_in_Sum } if
  %% read the limit value
  1 add NextNonBlankChar pop ReadNumber cvi 3 1 roll
  2 copy get 44 ne { ANALYZER_ERROR_missing_second_comma_in_Sum } if
  /ExpressionVector ExpressionVector aload length dup 7 add -3 roll 0 4 1 roll
  5 -1 roll 4 add array astore def
  %% keep ExpressionVector for later and create a new one for internal Sum computation
  ExpressionVector 3 1 roll /ExpressionVector [ 6 -1 roll cvn /exch cvx /def cvx ] def
  1 add NextNonBlankChar pop AnalyzeExpr
  %% add each term
  /ExpressionVector ExpressionVector aload length 1 add /add cvx exch array astore def
  /ExpressionVector 4 -1 roll aload length ExpressionVector cvx /for cvx 3 -1 roll 2 add
  array astore def 3 -1 roll pop 1 add
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Convert to radians if trigo function call
%% (name) ->
/TrigoFunc {
  dup (cos) eq 1 index (sin) eq or exch (tan) eq or
  { /ExpressionVector ExpressionVector aload length Pi /div cvx 180 /mul cvx 5 -1 roll 4 add
    array astore def
  } if
} def
/EvalCond {%
  pop 1 add AnalyzeCond NextNonBlankChar
  44 ne { ANALYZER_ERROR_missing_first_comma_in_IfTE } if
  ExpressionVector 3 1 roll /ExpressionVector [] def
  1 add AnalyzeExpr ExpressionVector 3 1 roll /ExpressionVector [] def
  NextNonBlankChar 44 ne { ANALYZER_ERROR_missing_second_comma_in_IfTE } if
  1 add AnalyzeExpr
  NextNonBlankChar 41 ne { ANALYZER_ERROR_missing_ending parenthesis_in_IfTE } if
  ExpressionVector
  /ExpressionVector 6 -1 roll aload length dup
  6 add -1 roll cvx exch dup 4 add -1 roll cvx /ifelse cvx 3 -1 roll 3 add array astore def
  1 add 3 -1 roll pop
} def
%% CondOp STR index
/EvalCondOp {%
  3 -1 roll
  dup (=) eq  { /eq } {%
  dup (<) eq  { /lt } {%
  dup (>) eq  { /gt } {%
  dup (>=) eq { /ge } {%
  dup (<=) eq { /ge } {%
  dup (!=) eq { /ne } { ERROR_non_valid_conditional_operator }
  ifelse } ifelse } ifelse } ifelse } ifelse } ifelse
  cvx exch pop
  /ExpressionVector ExpressionVector aload length dup 3 add -1 roll exch 1 add array astore def } def
/EvalUnaryOp {
  3 -1 roll 45 eq { /ExpressionVector ExpressionVector aload length /neg cvx exch 1 add array astore def } if
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% H O O K S
/AnalyzePreHook {} bind def
/PreEvalHook {} bind def
/AnalyzeListOfEPostHook {} bind def
/AnalyzePostHook {} def
/RollOp { 3 1 roll } bind def
end   %tx@CoreAnalyzerDict
%
%--------------------------------------------------------------------%
%
/tx@Derive 41 dict def tx@Derive begin
%%increase ^^ for each function added
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% algExpr variable -> PSVector
/Derive {%
  10240 string 3 1 roll 0 3 1 roll
  /Variable exch def
  tx@CoreAnalyzerDict begin InitParser AnalyzeListOfE end
} def
/Strlen 0 def
/InitParser { dup length /Strlen exch def 0 } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% algExpr variable index -> PSVector
/DeriveIndexed {%
  3 1 roll 10240 string 3 1 roll 0 3 1 roll
  /Variable exch def
  tx@CoreAnalyzerDict begin InitParser pop 4 -1 roll AnalyzeExpr 4 -2 roll pop pop 4 -2 roll exch pop end
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (u,v)'=-(u',v')
/EvalListOfExpr {%
  4 2 roll 2 copy 9 -1 roll dup length 4 1 roll putinterval add AddPipe
           2 copy 7 -1 roll dup length 4 1 roll putinterval add
  6 -2 roll pop pop
  2 copy pop 0 6 2 roll GetIntervalNewStr 5 1 roll 2 copy 0 exch getinterval 6 1 roll } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (-u)'=-(u')
/EvalUnaryOp {
  4 -2 roll 4 index (0) eq
  { (0) StrConcat 7 -1 roll pop }
  { 7 -1 roll 45 eq
    { AddSub AddOpPar true } { false } ifelse
    3 1 roll 5 index StrConcat 3 -1 roll { AddClPar } if } ifelse
  2 copy pop 0 6 2 roll GetIntervalNewStr
  7 -2 roll pop pop 2 index 6 index dup 4 index exch sub getinterval exch 6 2 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (number)'=0
/EvalNumber { ReadNumber (0) 6 2 roll } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (u+v)'=u'+v'
/EvalAddSub {%
  7 index dup (0) eq
  { pop true }%% du=0 nothing added
  { dup length exch 5 index 5 index 3 -1 roll putinterval 4 -1 roll add 3 1 roll false }
  ifelse
  5 index dup (0) eq
  { pop { (0) } { 4 -2 roll 2 copy pop 0  6 2 roll GetIntervalNewStr } ifelse }%%dv=0
  { exch
    { 5 -2 roll 7 index 45 eq { AddSub } if false } %%nothing yet added
    { 5 -2 roll 7 index 43 eq%%something yet added
      { AddAdd false } { AddSub AddOpPar true } ifelse }
    ifelse 11 1 roll
    3 -1 roll StrConcat 10 -1 roll { AddClPar } if
    2 copy pop 0 6 2 roll GetIntervalNewStr }
  ifelse
  mark 11 -5 roll cleartomark 2 index 6 index dup 4 index exch sub getinterval exch 6 2 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (u*v)' or (u/v)'
/EvalMulDiv { 6 index 42 eq {EvalMul} {EvalDiv} ifelse } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (u*v)'=u'*v+u*v'
/EvalMul {%
  4 -2 roll 7 index dup (0) eq
  { pop false }%%du=0
  { (1) eq%%du=1
    { false }
    { AddOpPar 7 index StrConcat AddClPar AddMul AddOpPar true } ifelse
    3 1 roll 6 index StrConcat 3 -1 roll { AddClPar } if
    true }%%du!=0
  ifelse
  5 1 roll 5 index (0) eq
  { 5 -1 roll not { (0) StrConcat } if }%%dv=0
  { 5 -1 roll { AddAdd } if
    4 index (1) eq
    { 8 index StrConcat }
    { AddOpPar 8 index StrConcat AddClPar AddMul AddOpPar 4 index StrConcat AddClPar }
    ifelse
  }%%dv!=0
  ifelse
  2 copy pop 0 6 2 roll GetIntervalNewStr
  mark 11 -5 roll cleartomark 2 index 6 index dup 4 index exch sub getinterval exch 6 2 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (u/v)'=(u'*v-u*v')/v^2
/EvalDiv {%
  4 -2 roll
  4 index (0) eq%%dv=0 -> u'/v
  { 7 index (0) eq { (0) StrConcat } { AddOpPar 7 index StrConcat AddClPar AddDiv 5 index StrConcat } ifelse }
  { 7 index dup (0) eq
    { pop }%%du=0
    { (1) eq%%du=1
      { false }
      { AddOpPar 7 index StrConcat AddClPar AddMul AddOpPar true } ifelse
      3 1 roll 6 index StrConcat 3 -1 roll { AddClPar } if}%%du!=0
    ifelse
      AddSub
      4 index (1) eq
      { 8 index StrConcat }
      { AddOpPar 8 index StrConcat AddClPar AddMul AddOpPar 4 index StrConcat AddClPar }
      ifelse
    %}%%dv!=0
    2 copy GetIntervalNewStr 3 1 roll pop 0 AddOpPar 3 -1 roll StrConcat AddClPar
    AddDiv AddOpPar 5 index StrConcat AddClPar 2 copy (^2) putinterval 2 add }
  ifelse
  2 copy pop 0 6 2 roll GetIntervalNewStr
  mark 11 -5 roll cleartomark 2 index 6 index dup 4 index exch sub getinterval exch 6 2 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% str1 index str2 -> str1 index
/StrConcat { dup length 4 2 roll 2 copy 6 -1 roll putinterval 3 -1 roll add } bind def
/GetIntervalNewStr { 0 exch getinterval dup length string copy } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (u^v)'=(u^v)'=u'vu^(v-1)+v'u^(v)ln(u)
/EvalPower {%
  4 -2 roll 7 index (0) eq
  {%%if du=0 then (u^v)'=v'ln(u)u^v
    4 index (0) eq
    { (0) StrConcat }%%if dv=0 then (u^v)'=0
    { 4 index (1) ne { AddOpPar 4 index StrConcat (\)*) StrConcat } if
      8 index (e) ne { (ln\() StrConcat 8 index StrConcat (\)*) StrConcat } if
      AddOpPar 8 index StrConcat (\)^\() StrConcat 5 index StrConcat AddClPar } ifelse
  }
  {%%du!=0
    4 index (0) eq
    {%%if dv=0 then (u^v)'=vu'u^(v-1)
      5 index dup IsStrNumber
      { dup (0) eq
        { StrConcat }
        { dup dup (1) eq exch (1.0) eq or
          { StrConcat  }
	  { StrConcat
	    7 index dup (1) ne exch (1.0) ne and%%%dr 09102006 insert du if <> 1
	    { (*\() StrConcat 7 index StrConcat (\)) StrConcat } if%%%dr 09102006
            (*\() StrConcat 8 index StrConcat (\)) StrConcat
            5 index  dup dup (2) eq exch (2.0) eq or
	    { pop } { cvr 1 sub 20 string cvs 3 1 roll (^) StrConcat 3 -1 roll StrConcat } ifelse } ifelse } ifelse }
      { pop AddOpPar 5 index StrConcat (\)*\() StrConcat 8 index StrConcat (\)^\() StrConcat
        5 index StrConcat (-1\)) StrConcat } ifelse
    }
    {%%if dv!=0 and du!=0 then (u^v)'=u'vu^(v-1)+v'u^(v)ln(u)
      7 index (1) ne { AddOpPar 7 index StrConcat (\)*) StrConcat } if
      AddOpPar 5 index StrConcat (\)*\() StrConcat
      8 index StrConcat (\)^\() StrConcat
      5 index StrConcat (-1\)+\() StrConcat
      4 index (1) ne { 4 index StrConcat (\)*\() StrConcat } if
      8 index StrConcat (\)^\() StrConcat
      5 index StrConcat (\)*ln\() StrConcat
      8 index StrConcat AddClPar
    } ifelse
  } ifelse
  2 copy pop 0 6 2 roll GetIntervalNewStr
  mark 11 -5 roll cleartomark 2 index 6 index dup 4 index exch sub getinterval exch 6 2 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% No derivative for factorial ! only cst => null derivative
/EvalFactorial {% DR 09/2011
  4 index (0) eq
  { (0) mark 8 -2 roll  cleartomark 2 index 7 index dup 4 index exch sub getinterval exch 6 2 roll }
  { DERIVATIVE_ENGINE_ERROR_no_variable_in_factorial } ifelse
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% str -> true/false
/IsStrNumber {%
  true exch
  { dup 48 lt exch dup 57 gt 3 -1 roll or
    exch dup 46 ne%%.
    exch dup 43 ne%%+
    exch 45 ne%%-
    and and and { pop false } if } forall
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% literal switch -> func call, vector, variables
/EvalLiteral {%
  ReadLiteral dup 40 eq%%% there is an open par -> function call
  { pop (EvalFunc_             ) 9 4 index StrConcat 0 exch getinterval cvn cvx exec }
  { dup 91 eq%%% there is an open bracket -> vector element
    { DERIVATIVE_ENGINE_ERROR_vector_not_yet_implemented }
    { pop EvalVariable }
    ifelse }
  ifelse
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% first last parpos Expr[first:parpos-1] ->
/EvalVariable { 2 index Variable eq { (1) } { (0) } ifelse 4 -1 roll exch 6 2 roll } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (f(u))'=u'f'(u)
/EvalFunc {
  4 2 roll 4 index (1) ne
  { AddOpPar 4 index StrConcat (\)*) StrConcat } if
  (Eval             ) 4 8 index StrConcat 0 exch getinterval cvn cvx exec
  2 copy pop 0 6 2 roll GetIntervalNewStr
  mark 9 -3 roll cleartomark 2 index 6 index dup 4 index exch sub getinterval exch 6 2 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Func derivative -> Eval<func>
/EvalFunc_sin {%
  PreCommonFunc
  { (cos\() StrConcat 5 index StrConcat AddClPar } if
  PostCommonFunc } def
/EvalFunc_cos {%
  PreCommonFunc
  { (\(-sin\() StrConcat 5 index StrConcat (\)\)) StrConcat } if
  PostCommonFunc } def
/EvalFunc_tan {%
  PreCommonFunc
  {  dup 0 eq { (1) StrConcat } { 1 sub } ifelse  (/cos\() StrConcat 5 index StrConcat (\)^2) StrConcat } if
  PostCommonFunc } def
/EvalFunc_asin {%
  PreCommonFunc
  { (1/sqrt\(1-\() StrConcat 5 index StrConcat (\)^2\)\)) StrConcat } if
  PostCommonFunc } def
/EvalFunc_acos {%
  PreCommonFunc
  { (-1/sqrt\(1-\() StrConcat 5 index StrConcat (\)^2\)\)) StrConcat } if
  PostCommonFunc } def
/EvalFunc_atg {%
  PreCommonFunc
  { (1/\(1+\() StrConcat 5 index StrConcat (\)^2\)\)) StrConcat } if
  PostCommonFunc } def
/EvalFunc_ln {%
  PreCommonFunc
  {  dup 0 eq { (1) StrConcat } { 1 sub } ifelse (/\() StrConcat 5 index StrConcat AddClPar } if
  PostCommonFunc } def
/EvalFunc_exp {%
  PreCommonFunc
  {  (exp\() StrConcat 5 index StrConcat AddClPar } if
  PostCommonFunc } def
/EvalFunc_EXP {%
  PreCommonFunc
  {  (EXP\() StrConcat 5 index StrConcat AddClPar } if
  PostCommonFunc } def
/EvalFunc_sqrt {%
  PreCommonFunc
  { dup 0 eq { (1) StrConcat } { 1 sub } ifelse (/\(2*sqrt\() StrConcat 5 index StrConcat (\)\)) StrConcat } if
  PostCommonFunc } def
/EvalFunc_Fact {%
  PreCommonFunc { DERIVATIVE_ENGINE_ERROR_no_variable_expression_in_Fact } if
  PostCommonFunc } def
/EvalFunc_sh {%
  PreCommonFunc
  { (ch\() StrConcat 5 index StrConcat AddClPar } if
  PostCommonFunc } def
/EvalFunc_ch {%
  PreCommonFunc
  { (sh\() StrConcat 5 index StrConcat AddClPar } if
  PostCommonFunc } def
/EvalFunc_th {%
  PreCommonFunc
  {  dup 0 eq { (1) StrConcat } { 1 sub } ifelse  (/ch\() StrConcat 5 index StrConcat (\)^2) StrConcat } if
  PostCommonFunc } def
/EvalFunc_Argsh {%
  PreCommonFunc
  { (1/sqrt\(1+\() StrConcat 5 index StrConcat (\)^2\)\)) StrConcat } if
  PostCommonFunc } def
/EvalFunc_Argch {%
  PreCommonFunc
  { (1/sqrt\(\() StrConcat 5 index StrConcat (\)^2-1\)\)) StrConcat } if
  PostCommonFunc } def
/EvalFunc_Argth {%
  PreCommonFunc
  { (1/\(1-\() StrConcat 5 index StrConcat (\)^2\)\)) StrConcat } if
  PostCommonFunc } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/PreCommonFunc {
  1 add NextNonBlankChar pop 3 -1 roll 5 1 roll AnalyzeExpr 1 add NextNonBlankChar pop
  4 2 roll 4 index (0) eq
  { (0) StrConcat false }
  { 4 index (1)  ne { AddOpPar 4 index StrConcat (\)*) StrConcat } if true } ifelse
} def
/PostCommonFunc {
  2 copy pop 0 6 2 roll GetIntervalNewStr
  mark 9 -3 roll cleartomark 2 index 6 index dup 4 index exch sub getinterval exch 6 2 roll
} def
/EvalFunc_Derive {%
  1 add ReadNumber cvi 1 add dup cvr log 1 add cvi string cvs
  4 -1 roll pop 5 1 roll 1 add NextNonBlankChar pop AnalyzeExpr 1 add
  4 -2 roll (Derive\() StrConcat 7 -1 roll StrConcat (,) StrConcat 6 -1 roll StrConcat AddClPar
  2 copy pop 0 6 2 roll GetIntervalNewStr 6 -1 roll pop 2 index 6 index dup 4 index exch sub getinterval
  exch 6 2 roll } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% literal switch -> func call, vector, variables
/EvalFunc_Sum {%
  1 add NextNonBlankChar pop
  %% read the variable name
  ReadLiteral pop 3 -1 roll pop NextNonBlankChar
  44 ne { ANALYZER_ERROR_missing_first_comma_in_Sum } if
  %% read the initial value
  1 add NextNonBlankChar pop ReadNumber pop
  2 copy get 44 ne { ANALYZER_ERROR_missing_second_comma_in_Sum } if
  %% read the increment value
  1 add NextNonBlankChar pop ReadNumber pop
  2 copy get 44 ne { ANALYZER_ERROR_missing_third_comma_in_Sum } if
  %% read the limit value
  1 add NextNonBlankChar pop ReadNumber pop
  2 copy get 44 ne { ANALYZER_ERROR_missing_fourth_comma_in_Sum } if
  1 add NextNonBlankChar pop dup 6 1 roll 3 -1 roll pop AnalyzeExpr 1 add NextNonBlankChar pop
  4 -2 roll 3 index 8 index dup 9 index exch sub getinterval StrConcat
  4 index StrConcat AddClPar
  2 copy pop 0 6 2 roll GetIntervalNewStr
  mark 9 -3 roll cleartomark 2 index 6 index dup 4 index exch sub getinterval exch 6 2 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% literal switch -> func call, vector, variables
/EvalFunc_IfTE {%
  3 -1 roll pop 1 add NextNonBlankChar pop SkipCond
  NextNonBlankChar
  44 ne { ANALYZER_ERROR_missing_first_comma_in_IfTE } if
  1 add NextNonBlankChar pop dup 5 1 roll
  AnalyzeExpr NextNonBlankChar
  44 ne { ANALYZER_ERROR_missing_second_comma_in_IfTE } if
  1 add NextNonBlankChar pop
  AnalyzeExpr 1 add NextNonBlankChar pop
  4 -2 roll 3 index 10 index dup 11 index exch sub getinterval StrConcat
  6 index StrConcat (,) StrConcat 4 index StrConcat AddClPar
  2 copy pop 0 6 2 roll GetIntervalNewStr
  mark 11 -5 roll cleartomark 2 index 6 index dup 4 index exch sub getinterval exch 6 2 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% advance in str until a comma is found (no error detection!)
%% str index -> str index'
/SkipCond { { 1 add 2 copy get 44 eq {exit } if } loop } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Convert to radians if trigo function call
%% (name) ->
/TrigoFunc {
  dup (cos) eq 1 index (sin) eq or exch (tan) eq or
  { /ExpressionVector ExpressionVector aload length Pi /div cvx 180 /mul cvx 5 -1 roll 4 add
    array astore def
  } if
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% No derivative for condition....
/EvalCondOp { 3 -1 roll pop } bind def
/PutIntervalOneAdd {putinterval 1 add} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Add open parenthesis in string at the given index
%% str index -> str index+1
/AddOpPar {2 copy (\() PutIntervalOneAdd} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Add close parenthesis in string at the given index
%% str index -> str index+1
/AddClPar {2 copy (\)) PutIntervalOneAdd} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Add 0 in string at the given index
%% str index -> str index+1
/AddZero {2 copy (0) PutIntervalOneAdd} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Add open parenthesis in string at the given index
%% str index -> str index+1
/AddMul {2 copy (*) PutIntervalOneAdd} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Add open parenthesis in string at the given index
%% str index -> str index+1
/AddDiv {2 copy (/) PutIntervalOneAdd} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Add a plus sign in string at the given index
%% str index -> str index+1
/AddAdd {2 copy (+) PutIntervalOneAdd} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Add a minus sign in string at the given index
%% str index -> str index+1
/AddSub {2 copy (-) PutIntervalOneAdd} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Add a pipe sign in string at the given index
%% str index -> str index+1
/AddPipe {2 copy (|) PutIntervalOneAdd} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% H O O K S
/AnalyzePreHook { dup 5 1 roll } bind def
/PreEvalHook {} def
/AnalyzePostHook { 7 -1 roll pop } bind def
/AnalyzeListOfEPostHook { 6 -1 roll mark 6 1 roll cleartomark } bind def
/RollOp { 5 1 roll } bind def
end%%%tx@CoreAnalyzerDict
/tx@AddMathFunc 12 dict def tx@AddMathFunc begin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NEW FUNC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% function arcsine in radians asin(x)=atan(x/sqrt(1-x^2))
%% x -> theta
/asin {%
  dup abs 1 gt { EQDFasinrangeerror  } if
  dup dup dup mul 1 exch sub sqrt atan exch 0 lt { 360 sub } if DegtoRad
} def
%% function arccosine in radians acos(x)=atan(sqrt(1-x^2)/x)
%% x -> theta
/acos {%
  dup abs 1 gt { EQDFacosrangeerror  } if
  dup dup mul 1 exch sub sqrt exch atan DegtoRad
} def
%% function arctangent in radians
%% x -> theta
/atg { 1 atan dup 90 gt { 360 sub } if DegtoRad } bind def
%% HYPERBOLIC FUNCTIONS
/sh { dup Ex exch neg Ex sub 2 div } def
/ch { dup Ex exch neg Ex add 2 div } def
/th { dup sh exch ch div } def
/Argsh { dup dup mul 1 add sqrt add ln } def
/Argch { dup dup mul 1 sub sqrt add ln } def
/Argth { dup 1 add exch 1 exch sub div ln 2 div } def
%% modified exponential funtion for 0
%% x n -> x^n
/Exp { dup 0 eq { pop pop 1 } { exp } ifelse } bind def
%% modified exponential funtion for 0
%% x -> e^x
/Ex { Euler exch exp } bind def
%%
%% factorial function
%% n -> n!
/Fact { 1 exch 2 exch 1 exch { mul } for } bind def
/fact { Fact } bind def
/! { Fact } bind def
end
%
% END pst-algparser.pro