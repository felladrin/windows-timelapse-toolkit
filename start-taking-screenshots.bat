@ECHO off
IF NOT EXIST %cd%\lib\screenshot-cmd.exe (
	ECHO Error: screenshot-cmd is missing.
	ECHO Please, download the complete time lapse toolkit from here:
	ECHO https://github.com/felladrin/windows-timelapse-toolkit/releases
	ECHO Or download it from https://code.google.com/archive/p/screenshot-cmd and place a copy of 'screenshot-cmd.exe' in the folder %cd%\lib
	PAUSE
	EXIT /b
)
IF NOT EXIST %cd%\screenshots MKDIR %cd%\screenshots
FOR /F "tokens=*" %%I in (config.ini) DO SET %%I
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET SessionId=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%
IF NOT EXIST %cd%\screenshots\%SessionId% MKDIR %cd%\screenshots\%SessionId%
ECHO Started Taking Screenshots...
ECHO A screenshot will be taken every %ScreenshotInterval% seconds and saved to the folder %cd%\screenshots\%SessionId%
:loop
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET DateTime=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%
SET ScreenshotPath=%cd%\screenshots\%SessionId%\%DateTime%.png
%cd%\lib\screenshot-cmd.exe -o %ScreenshotPath%
ECHO Screnshot Taken! (%ScreenshotPath%)
TIMEOUT /nobreak /t %ScreenshotInterval%
GOTO loop