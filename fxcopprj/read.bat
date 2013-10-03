@setlocal enableextensions enabledelayedexpansion
@echo off
Set mydir=%~d1\%~n1\
echo %mydir%
find /c ".csproj" %1
rem for /f  "tokens=*" %%l in (%1) do echo %%l