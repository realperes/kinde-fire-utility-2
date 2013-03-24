@ECHO off
rem Installs Freedom-Boot and TWRP for the Kindle Fire 2
rem Developed by RainbowDashDC
rem -----------------------------------------------------------------------
REM <Installs Freedom-Boot and TWRP for the Kindle Fire 2>
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
REM License not included.
rem -----------------------------------------------------------------------

REM Clear ERRMSG's
set errmsg=
set e=
set VERBOSE=0

REM Details.
SET VER=1.1
SET DATE=[24/3/2013]


:LOOP
	IF NOT "%1" == "" (
		IF "%1" == "--help" (
			GOTO:HELP
		)
		IF "%1" == "--version" (
			GOTO:VERSION
		)
		IF "%1" == "-v" (
			SET VERBOSE=1
			GOTO:VERBOSE
		)
		IF "%1" == "call" (
			GOTO:CALL
		)
		
		echo.
		set errmsg=%1 is not a valid switch/command
		set e=1
		GOTO:HELP
	) ELSE (
		GOTO:RECOV_BOOT
	)
GOTO:HELP && REM Just incase we have a lost argument, redirect to help

:HELP
	echo Automated Freedom-Boot and TWRP installer - %VER%
	echo.
	echo Installs Freedom-Boot and TWRP for the Kindle Fire 2
	echo USAGE: runme.bat [OPTION]... 
	echo.
	echo General:
	echo. 	--help                        Shows this help page.
	echo.	--version                     Shows the version.
	echo.	-v                            Verbose Install.
	echo.
	echo Bug reports and suggestions: [http://goo.gl/2cHHA]
	echo (http://forum.xda-developers.com/showthread.php?t=2106463)
	if "%e%" == "1" echo. && echo Error: %errmsg%
GOTO:EXIT

:VERSION
	echo Automated Freedom-Boot and TWRP installer - %VER%
	echo.
	echo Version: %VER% - %DATE%
	echo.
	echo Do --help for more information.
GOTO:EXIT

:VERBOSE
	ECHO Displaying verbose output...
GOTO:RECOV_BOOT


:RECOV_BOOT
	echo Begin Installer? (Don't worry, it waits for device :) )
	PAUSE
	
	set /p "=Removing install-recovery.sh... " <nul
	IF "%VERBOSE%" == "1" echo.
	IF "%VERBOSE%" == "1" echo.	- Waiting for Device...
	stuff\adb\windows\adb wait-for-device
	IF "%VERBOSE%" == "1" echo.	- Mounting system as writeable.
	stuff\adb\windows\adb shell su -c "mount -o remount,rw -t ext4 /system /system "
	IF "%VERBOSE%" == "1" echo.	- Mounting sdcard as writeable.
	stuff\adb\windows\adb shell su -c "mount -o remount,rw -t ext4 /sdcard /sdcard " 
	IF "%VERBOSE%" == "1" echo.	- Removing /system/etc/install-recovery.sh
	stuff\adb\windows\adb shell su -c "rm /system/etc/install-recovery.sh"
	IF "%VERBOSE%" == "1" echo.	- Removing /system/RECOVERY-AMZN-4430-OTTER2-PROD
	stuff\adb\windows\adb shell su -c "rm /system/RECOVERY-AMZN-4430-OTTER2-PROD"
	IF "%VERBOSE%" == "1" echo DONE && ECHO.
	IF NOT "%VERBOSE%" == "1" ECHO OK
	
	set /p "=Pushing Stack... " <nul
	IF "%VERBOSE%" == "1" echo.
	IF "%VERBOSE%" == "1" echo.	- Waiting-for-device...
	stuff\adb\windows\adb wait-for-device
	IF "%VERBOSE%" == "1" echo.	- Pushing stuff/stack to /sdcard/
	stuff\adb\windows\adb push stuff/stack /sdcard/
	IF "%VERBOSE%" == "1" echo.	- DD'ing if=/sdcard/stack of=/data/local/tmp/stack
	stuff\adb\windows\adb shell su -c "dd if=/sdcard/stack of=/data/local/tmp/stack"
	IF "%VERBOSE%" == "1" echo DONE && ECHO.
	IF NOT "%VERBOSE%" == "1" ECHO OK
	
	set /p "=Inserting stack override to /system... " <nul
	stuff\adb\windows\adb wait-for-device
	stuff\adb\windows\adb shell su -c "dd if=/data/local/tmp/stack of=/dev/block/platform/omap/omap_hsmmc.1/by-name/system bs=6519488 seek=1"
	ECHO OK
	
	set /p "=Pushing freedom-boot... "
	stuff\adb\windows\adb wait-for-device
	stuff\adb\windows\adb push stuff/boot.img /sdcard/
	ECHO OK
	
	set /p "=Pushing TeamWinRecoveryProject... "
	stuff\adb\windows\adb wait-for-device
	stuff\adb\windows\adb push stuff/recovery.img /sdcard/
	ECHO OK
	
	set /p "=ECHO Writing freedom-boot to /boot via dd... "
	stuff\adb\windows\adb wait-for-device
	stuff\adb\windows\adb shell su -c 'dd if=/sdcard/boot.img of=/dev/block/platform/omap/omap_hsmmc.1/by-name/boot'
	ECHO OK
	
	set /p "=ECHO Writing TWRP to recovery via dd... "
	stuff\adb\windows\adb wait-for-device
	stuff\adb\windows\adb shell su -c 'dd if=/sdcard/recovery.img of=/dev/block/platform/omap/omap_hsmmc.1/by-name/recovery'
	ECHO OK
	
	set /p  "=Rebooting... "
	stuff\adb\windows\adb wait-for-device
	stuff\adb\windows\adb shell su -c 'reboot'
	stuff\adb\windows\adb wait-for-device
	ECHO OK
GOTO:DONE


:DONE
	ECHO All Done!
	ECHO Make sure to press the power button during the secondary bootloader to reboot into recovery.
	ECHO -----------------------------------------------------
	ECHO Script by RainbowDashDC (XDA: Jared631)
	ECHO Based off of script by, FMKilo@XDA-developers
	echo Go tell FMKilo he's amazing!
	ECHO -----------------------------------------------------
	ECHO.
	ECHO Press Enter to Exit.
	PAUSE
GOTO:EXIT


:CALL
	echo ----------------------------------
	echo - This is for Debugging Purposes -
	echo - Use with caution               -
	echo ----------------------------------
	echo.
	echo Calling %2 ...
	echo.
	call %2
	echo.
	echo ----------------------------------
	echo %2 has been called.
GOTO:EXIT

:EXIT
