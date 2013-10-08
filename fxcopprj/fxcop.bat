@setlocal enableextensions enabledelayedexpansion
@echo off
CLS

SET mydir=%~d1%~p1

SET PRJ=
SET TYPEPRJ=
SET CONFIGPRJ=
SET PLATFORMPRJ=
SET COMPILEREFERENCE=
SET LINEREFERENCE=
SET DLLFILE=
SET DLLSLIST=
SET NULL=

SET datetime=
SET separator=#
SET dthrfile=datahora.xsl
SET modeldthrfile=modeldatahora.xsl

echo Setting Date Hour File...
del !dthrfile!
for /f "tokens=1-3 delims=:," %%a in ("%TIME%") do (
SET h=%%a
if !h! lss 10 set h=!h: =0!
SET datetime=!datetime!%DATE% !h!:%%b:%%c
)

for /f "tokens=*" %%l in (!modeldthrfile!) do (
 set a=%%l
 set b=%%l
 set a=!a:value-of =!
 if NOT !a!==!b! set b=^<^xsl:value-of select=^"'^!datetime!^'"/>^
 echo !b! >> !dthrfile!
)


echo Getting List...
rem echo %mydir%
rem echo Solution: %~n1%~x1
echo Solution: %1
for /f "skip=2 tokens=2 delims=," %%a in ('find ".csproj" %1') do (
 SET OUTPUTPATH=
 SET FOUND=f
 SET PRJ=%%a
 SET PRJ=!PRJ:"=!
 SET PRJ=%mydir%!PRJ:~1!
 echo Project:!PRJ!
 for /f "skip=2 tokens=3 delims=<>" %%a in ('find "OutputType" !PRJ!') do if %%a==Library SET TYPEPRJ=%%a
 rem echo !TYPEPRJ!
 for /f "skip=2 tokens=3 delims=<>" %%a in ('find "Configuration Condition" !PRJ!') do SET CONFIGPRJ=%%a
 rem echo !CONFIGPRJ! 
 for /f "skip=2 tokens=3 delims=<>" %%a in ('find "Platform Condition" !PRJ!') do SET PLATFORMPRJ=%%a
 rem echo !PLATFORMPRJ!
 for /f "skip=2 tokens=3 delims=<>" %%a in ('find "Platform Condition" !PRJ!') do SET PLATFORMPRJ=%%a
 SET COMPILEREFERENCE=!CONFIGPRJ!^|^!PLATFORMPRJ!
 rem echo !COMPILEREFERENCE!
 for /f "skip=2 tokens=1 delims=[]'" %%a in ('find /n "!COMPILEREFERENCE!" !PRJ!') do SET LINEREFERENCE=%%a
 rem echo !LINEREFERENCE!
 for /f "skip=2 tokens=1-5 delims=[]<>" %%a in ('find /n "OutputPath" !PRJ!') do (
  if !FOUND! == f (
   if !LINEREFENCE! lss %%a (
    SET FOUND=t
	SET OUTPUTPATH=%%d
    for /f %%P in ("!PRJ!") do (
     SET DLLFILE=%%~dP%%~pP!OUTPUTPATH!%%~nP.dll
     SET DLLSLIST=!DLLSLIST! /f:!DLLFILE!
     echo DLL:!DLLFILE!
	 )))))
 if NOT !DLLSLIST! == !NULL! (
  echo Processing FxCop...
  "c:\Program Files (x86)\Microsoft Fxcop 10.0\FxCopCmd.exe"%DLLSLIST% /out:%CD%\relat.htm /oXsl:format.xsl /searchgac /axsl)
 if !DLLSLIST! == !NULL! echo NO DLL's FOUNDED