@echo off
@setlocal enableextensions enabledelayedexpansion
SET lines=
SET datetime=
SET separator=#
SET dthrfile=datahora.xsl
SET modeldthrfile=modeldatahora.xsl

del !dthrfile!
for /f "tokens=1-3 delims=:," %%a in ("%TIME%") do (
SET h=%%a
if !h! lss 10 set h=!h: =0!
SET datetime=!datetime!%DATE% !h!:%%b:%%c
)
rem echo !datetime!

for /f "tokens=*" %%l in (!modeldthrfile!) do (
 set a=%%l
 set b=%%l
 set a=!a:value-of =!
 if NOT !a!==!b! set b=^<^xsl:value-of select=^"'^!datetime!^'"/>^
 echo !b! >> !dthrfile!
 rem set lines=!lines!!b!!separator!
)
rem echo !lines!
rem for /f "tokens=1-6 delims=%separator%" %%a in ("!lines!") do (
rem echo %%a >> !dthrtime!
rem echo %%b >> !dthrtime!
rem echo %%c >> !dthrtime!
rem echo %%d >> !dthrtime!
rem echo %%e >> !dthrtime!
rem echo %%f >> !dthrtime!
)
rem @echo !lines! > !dthrtime!