@echo off
REM AUTHOR: RAINBOWDASHDC (@RAINDASHDC) (Jared631)
REM DATE: 24/03/13 (Started On)
REM DESC: Installs Kindle Fire 2 Drivers.
rem -----------------------------------------------------------------------
REM <See DESC>
REM Copyright (C) <2013>  <RainbowDashDC> <RDCODING BRANCH OF RDINC>
REM
REM This program is free software: you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM at your option) any later version.
REM
REM This program is distributed in the hope that it will be useful,
REM but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM GNU General Public License for more details.
REM
REM You should have received a copy of the GNU General Public License
REM along with this program.  If not, see <http://www.gnu.org/licenses/>.
REM
rem -----------------------------------------------------------------------

REM Look mommy, no WGET!


REM VARIABLES
set VER=1.0
set DATE=[24/3/13]
set NVER=
set NDATE=
set NURL=

set KFU_BIN=bin/
set KFU_SCRIPTS=scripts/

REM TOOLS
set ECHO=bin\echo
set WINGET-DL=bin\winget-dl.exe
set ADB=bin\adb.exe
set READ_INI=bin\read_ini.exe

:INSTALL_DRIVERS
	echo Calling kfu2.bat --install-drivers...
	CALL kfu2.bat --install-drivers
	echo ----------------------------------------
	echo We're Done!
	echo ----------------------------------------
	echo.
	echo Press Enter to Exit.
	set /P randomvar=""
	exit
GOTO:EXIT

:EXIT