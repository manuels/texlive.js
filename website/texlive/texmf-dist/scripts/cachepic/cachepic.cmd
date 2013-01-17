@echo off
setlocal enableextensions
if not defined LUA_EXE if exist "%~dp0lua.exe" set LUA_EXE=%~dp0lua.exe
for %%I in (lua.exe texlua.exe) do if not defined LUA_EXE set LUA_EXE=%%~$PATH:I
if not defined LUA_EXE goto :nolua
"%LUA_EXE%" "%~dp0cachepic.tlu" %*
goto :eof

:nolua
echo %~nx0: could not locate lua nor texlua interpreter>&2
exit /b 1