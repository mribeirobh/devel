@echo off
echo Processing FxCop...

setlocal ENABLEDELAYEDEXPANSION

REM Mounting Files

SET _files=

FOR /F %%i in (source.txt) do SET _files=!_files! /f:%%i

rem "c:\Program Files (x86)\Microsoft Fxcop 10.0\FxCopCmd.exe" %_files% /out:%CD%\relat.xml /oXsl:format.xsl /searchgac 

"c:\Program Files (x86)\Microsoft Fxcop 10.0\FxCopCmd.exe" %_files% /out:%CD%\relat.htm /oXsl:format.xsl /searchgac /axsl