@echo off
@setlocal EnableExtensions EnableDelayedExpansion

rmdir /s /q data\scripts

rem thx stackoverflow for this script

set mypath=%~dp0
set "openssl=C:\OpenSSL-Win64\bin\openssl.exe"
set "SourcePath=%mypath%data\scriptsSrc"
set "TargetPath=%mypath%data\scripts"

if not "%~1" == "" set "SourcePath=%~1"
if not "%~2" == "" set "TargetPath=%~2"

if "%SourcePath:~-1%" == "\" set "SourcePath=%SourcePath:~0,-1%"
if "%TargetPath:~-1%" == "\" set "TargetPath=%TargetPath:~0,-1%"

set "PathLength=1"
:GetPathLength
if not "!SourcePath:~%PathLength%,1!" == "" (
    set /A PathLength+=1
    goto GetPathLength
)

for /R "%SourcePath%" %%I in (*) do (
    set "RelativePath=%%~dpI"
    set "RelativePath=!RelativePath:~%PathLength%,-1!"
    md "%TargetPath%!RelativePath!" 2>nul
	%openssl% enc -K 55534361505170413454534E56784D49317639534B39554330795A75416E6232 -iv 00 -aes-256-cbc -in "%%I" -out "%TargetPath%!RelativePath!\%%~nxI"
)

%openssl% enc -K 55534361505170413454534E56784D49317639534B39554330795A75416E6232 -iv 00 -aes-256-cbc -in "data\images\pcSrc\loadlist.lua" -out "data\images\pc\loadlist.lua"
endlocal

start AngryBirds.exe