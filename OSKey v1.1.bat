@echo off
set load=+++++++
set loadnum=0
set flash=0
Title u\OSKey

set installspeed=1
set myapp=winkey.bat

:progressinstall
set load=%load%
cls
echo.
echo.
echo.
echo     Status: Extracting... 
echo  ---------------------------
echo  %load%
echo  ---------------------------
ping localhost -n %installspeed% >nul
set/a loadnum=%loadnum% +1
set/a flash=%flash% +1
if %flash% == 9 set flash=0
color 0%flash%
if %loadnum% == 10 set/a loadnum=0 & set load=
tasklist | find "%winkey%" > NUL
color A
color 5
color 6


setlocal
set v=Unimplemented version of Windows...
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set v=%%j.%%k) else (set v=%%i.%%j))
if "%v%" == "10.0" set v=Windows10
if "%v%" == "6.3" set v=Windows8.1
if "%v%" == "6.2" set v=Windows8
if "%v%" == "6.1" set v=Windows7
echo      OS Ver: %v%
echo.
echo Product-Key: >> %~dp0\ProductKeys.txt
For /f "tokens=2 delims=," %%a in ('wmic path SoftwareLicensingService get OA3xOriginalProductKey^,VLRenewalInterval /value /format:csv') do set key=%%a
if NOT [%key%]==[] (
  echo %key% >> %~dp0\ProductKeys.txt 
  ) else (
  echo.
  echo ERROR: EXPORT FAILED >> %~dp0\%v%.txt
  color 0c
  echo ERROR: EXPORT FAILED
  )
echo. >> %~dp0\ProductKeys.txt
if %loadnum% == 1 set/a loadnum=0 & set load=2
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"Host Name" >> %~dp0\ProductKeys.txt
echo. >> %~dp0\ProductKeys.txt
echo Status:  Bound [] Unbound [X] >> %~dp0\ProductKeys.txt
echo. >> %~dp0\ProductKeys.txt
echo ------------------------------------------------------------- >> %~dp0\ProductKeys.txt


:installcomplete
color A
cls
echo.
echo.
echo.
echo      Status: COMPLETE
echo  ---------------------------
echo  +++++++++++++++++++++++++++
echo  ---------------------------
echo   Saved to ProductKeys.txt
echo.
echo.
echo    Product-Key Exctacted!
echo.
echo.
echo   Press any key to close...
echo.
echo  github.com/twituserjosh/uOSKey
echo.
pause >nul
cls
