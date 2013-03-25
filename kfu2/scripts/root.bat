@echo off
rem Root Script for Kindle Fire 2
rem Developed by RainbowDashDC
rem -----------------------------------------------------------------------
REM <Root Script for Kindle Fire 2>
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

SET VER=1.1
SET DATE=[24/3/13]

set KFU_BIN=bin/
set KFU_SCRIPTS=scripts/

REM TOOLS
set ECHO=bin\echo
set WINGET-DL=bin\winget-dl.exe
set ADB=bin\adb.exe
set READINI=bin\read_ini

:ROOT
	ECHO Root Script V%VER% - %DATE%
	ECHO By RainbowDashDC
	ECHO ----------------------------
	ECHO.
	ECHO Begin?
	pause

	ECHO Waiting for Device...
	%ADB% wait-for-device
	
	echo Pushing Files...
	%ADB% push root/busybox /data/local/tmp/busybox
	%ADB% push root/su /data/local/tmp/tmp
	%ADB% push root/Superuser.apk /data/local/tmp/Superuser.apk
	%ADB% push root/ric /data/local/tmp/ric
	
	REM CHMOD & While LOOP
	echo CHMOD'in /data/local/tmp/busybox to 755
	%ADB% shell -c "chmod 755 /data/local/tmp/busybox
	%ADB% shell "while ! ln -s /data/local.prop /data/data/com.android.settings/a/file99; do :; done" > /dev/null
	
	REM We Need Another Window?
	echo Starting Restore for 'fakebackup.ab'
	%ADB% restore root/fakebackup.ab
	echo Check your Kindle Screen, You Should have a Restore Request.
	echo Click Yes.
	pause
	
	%ADB% wait-for-device
	
	echo Rebooting...
	%ADB% reboot
	
	echo Waiting-For-Device
	%ADB% wait-for-device
	
	echo Mounting /System as Writeable
	%ADB% shell -c "/data/local/tmp/busybox mount -o remount,rw /system /system"
	
	echo Moving SU, and RIC to /system/xbin and /system/bin
	%ADB% shell -c "/data/local/tmp/busybox mv /data/local/tmp/su /system/xbin/su"
	%ADB% shell -c "/data/local/tmp/busybox mv /data/local/tmp/ric /system/bin/ric"
	%ADB% shell -c "chmod 755 /system/bin/ric"
	
	echo Installing SuperUser and BusyBox
	%ADB% shell -c "/data/local/tmp/busybox mv /data/local/tmp/Superuser.apk /system/app/Superuser.apk"
	%ADB% shell -c "/data/local/tmp/busybox cp /data/local/tmp/busybox /system/xbin/busybox"
	%ADB% shell -c "chown 0.0 /system/xbin/su && chmod 06755 /system/xbin/su"
	%ADB% shell -c "chmod 655 /system/app/Superuser.apk"
	%ADB% shell -c "chmod 755 /system/xbin/busybox"
	
	echo Removing /data/local.prop
	%ADB% shell -c "rm /data/local.prop"
	%ADB% shell -c "reboot"
	call:DONE
GOTO:EOF

:DONE
	echo Done!
	echo -----------------------------
	echo You Should have Root!
	echo Enjoy!
	echo -----------------------------
	echo.
	echo Press Enter To Exit.
	SET /P temp=""
GOTO:EOF