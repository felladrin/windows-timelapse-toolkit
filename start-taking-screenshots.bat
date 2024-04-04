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
	TASKLIST /NH /FI "IMAGENAME eq RBTray.exe" | FIND /I "RBTray.exe" >NUL || START %cd%\tools\RBTray.exe
	ECHO/
	ECHO To hide this window in the system tray press the minimize button with the RIGHT Mouse Button.
)

SET /A Counter=0

:loop

TIMEOUT /nobreak /t %ScreenshotInterval%

FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET DateTime=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%

set /A Counter+=1

IF %UsePictureCounter%==true (
	SET ScreenshotPath=%cd%\screenshots\%SessionId%\%Counter%.jpg
) ELSE (
	SET ScreenshotPath=%cd%\screenshots\%SessionId%\%DateTime%.jpg
)

call %cd%\tools\screenCapture.bat %ScreenshotPath%

GOTO loop
