@echo off
REM Run this as Administrator
REM Change IFACE below to your interface number from "snort -W"

set IFACE=2
set SNORT_HOME=C:\Snort
set CONF=%SNORT_HOME%\etc\snort.conf
set LOG=%SNORT_HOME%\log

echo.
echo Validating configuration...
"%SNORT_HOME%\bin\snort.exe" -T -c "%CONF%" -l "%LOG%"
if errorlevel 1 (
  echo Validation failed. Fix errors above and re-run.
  exit /b 1
)

echo.
echo Starting Snort on interface %IFACE% ...
echo (Press Ctrl+C to stop)
"%SNORT_HOME%\bin\snort.exe" -A console -i %IFACE% -c "%CONF%" -l "%LOG%" -K ascii
