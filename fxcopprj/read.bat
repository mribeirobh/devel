@setlocal enableextensions enabledelayedexpansion
@echo off
CLS

SET mydir=%~d1%~p1
SET FPRJS=
SET AFPRJS=
SET CFPRJS=
SET LPRJS=

for /f "skip=2 tokens=2 delims=," %%a in ('find ".csproj" %1') do SET FPRJS=!FPRJS!%%a
SET FPRJS=%FPRJS:~1%
SET FPRJS=!FPRJS:"=!
echo Solution: %~n1%~x1
for %%f in (%FPRJS%) do for /f "skip=2 tokens=3 delims=<>" %%a in ('find "OutputType" %mydir%%%f') do if %%a==Library (SET AFPRJS=!AFPRJS!%%f )
for %%f in (%AFPRJS%) do for /f "skip=2 tokens=3 delims=<>" %%a in ('find "Configuration Condition" %mydir%%%f') do SET CFPRJS=!CFPRJS!%%f#%%a 
for %%l in (%CFPRJS%) do for /f "tokens=1* delims=#" %%y in ("%%l") do for /f "skip=2 tokens=1-5 delims=[]'" %%a in ('find /n "PropertyGroup Condition" %mydir%%%y') do echo %%a %%e %%z
