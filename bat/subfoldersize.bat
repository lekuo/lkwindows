@echo off
pushd "D:\Andy\Google Drive\andy"
for /f "delims=" %%a in (' dir /ad /b ') do call :size "%%~fa"
sort /r < "%temp%\dirsize.tmp"
del "%temp%\dirsize.tmp"
popd
pause
goto :eof

:size
for /f "tokens=3" %%b in ('dir /s "%~1" 2^>nul ^|find " File(s) "') do set "n=%%b"
set dirsize=%n%
REM set dirsize=%dirsize:,=%
set dirsize=                 %dirsize%
set dirsize=%dirsize:~-18%
>>"%temp%\dirsize.tmp" echo %dirsize% "%~1"