@echo off
set RVER=1.4
set RDATE=[21/02/2013]

if "%1" == "--version" (
	echo RDC - READ_INI %RVER%
	echo.
	echo Version: %RVER% - %RDATE%
	goto:EXIT
) else ( 
	set INIFILE="%1"
	
	FOR /F "eol=; eol=# tokens=1,2* delims==" %%i in ('findstr /b /l /i %~2= %1') DO (
		set %~4=%%~j
		echo Setting %~4
	)
)