@echo off
set "openssl=C:\OpenSSL-Win64\bin\openssl.exe"
set arg1=%1
set arg2=%2

mkdir temp\%arg1%
echo. filename = "%arg2%" >> data\%arg1%%arg2%
%openssl% enc -K 55534361505170413454534E56784D49317639534B39554330795A75416E6232 -iv 00 -aes-256-cbc -in data\%arg1%%arg2% -out temp\%arg1%%arg2%
move temp\%arg1%%arg2% data\%arg1%%arg2%
rmdir /s /q temp