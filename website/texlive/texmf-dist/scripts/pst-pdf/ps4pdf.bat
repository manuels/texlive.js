:: **********************************************
:: ps4pdf.bat
:: author Lutz Ihlenburg, 09-may-2005
::
:: Batch file for using Rolf Niepraschk's package 
:: pst-pdf under MiKTeX
::
:: More info: ps4pdf-bat.txt
:: **********************************************

@echo off
:: Command extensions must be enabled (Default in Windows XP)
:: Localize temporary variables
setlocal

:: Called with no argument?
if {%1} == {} goto USAGE
if {%1} == {/?} goto USAGE
if {%1} == {-h} goto USAGE
if {%1} == {--help} goto USAGE

:: Look for existence of main tex file.
:: This procedure will not work, if You transfer a filename without extension,
:: having dots in the name :-)
:: Command shell for-statement allows only one command.
::   For more, a multiple command must be created with &
for %%a in (%1) do set _fullname=%%~fa& set _drive=%%~da& set _path=%%~pa& set _name=%%~na& set _ext=%%~xa
:: XP command shell doesn't know "if not defined..."
if defined _ext ( 
rem
) else (
set _ext=.tex
set _fullname=%_fullname%.tex
)
if not exist "%_fullname%" goto :MISSINGFILE

:OPERATION
%_drive%
cd %_path%
@echo on
latex --src -interaction=nonstopmode "%_name%%_ext%" >"%_name%-ps4pdf.log"
@if errorlevel 1 goto :ERROR
dvips -o "%_name%-pics.ps" "%_name%.dvi" >>"%_name%-ps4pdf.log"
@if errorlevel 1 goto :ERROR
ps2pdf -dAutoRotatePages#/None "%_name%-pics.ps" >>"%_name%-ps4pdf.log"
@if errorlevel 1 goto :ERROR
texify -b -l latex -p "%_name%%_ext%" >>"%_name%-ps4pdf.log"
@if errorlevel 1 goto :ERROR
@goto :EOF

:MISSINGFILE
echo *** File not found: %_fullname%
echo *** Batch job aborted 
pause
goto :EOF

:ERROR
@echo *** An error message appeared. Abnormal termination! Look at %_name%-pst-pdf.log ***
@pause
@goto :EOF

:USAGE 
for %%a in (%0) do set _progname=%%~na
echo Usage: %_progname% SourceFile[.tex]
pause
goto :EOF
%~na
echo Usage: %_progname% SourceFile[.tex]
pause
goto :EOF
