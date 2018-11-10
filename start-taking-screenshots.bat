@ECHO off

IF NOT EXIST %cd%\screenshots MKDIR %cd%\screenshots

FOR /F "tokens=*" %%i IN (%cd%\config.ini) DO SET %%i

FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET SessionId=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%

IF NOT EXIST %cd%\screenshots\%SessionId% MKDIR %cd%\screenshots\%SessionId%

ECHO Started Taking Screenshots...
ECHO/
ECHO A screenshot will be taken every %ScreenshotInterval% seconds and saved to the following folder:
ECHO %cd%\screenshots\%SessionId%

IF %UseRBTray%==true (
	IF NOT EXIST %cd%\tools\RBTray.exe (
		ECHO Error: RBTray is missing.
		ECHO Please, download the complete time lapse toolkit from here:
		ECHO https://github.com/felladrin/windows-timelapse-toolkit/releases
		ECHO Or download RBTray from http://rbtray.sourceforge.net and place 'RBTray.exe' and 'RBHook.dll' in the folder %cd%\tools
		PAUSE
		EXIT /b
	) ELSE (
		TASKLIST /NH /FI "IMAGENAME eq RBTray.exe" | FIND /I "RBTray.exe" >NUL || START %cd%\tools\RBTray.exe
		ECHO/
		ECHO To hide this window to system tray press the minimize button with the RIGHT Mouse Button.
	)
)

:loop

TIMEOUT /nobreak /t %ScreenshotInterval%

FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET DateTime=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%

SET ScreenshotPath=%cd%\screenshots\%SessionId%\%DateTime%.jpg

%cd%\tools\screenCapture.exe %ScreenshotPath%

ECHO/
ECHO Screnshot Taken! (%ScreenshotPath%)

GOTO loop
