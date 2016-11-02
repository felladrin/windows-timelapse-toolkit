@ECHO off
IF NOT EXIST %cd%\lib\ffmpeg.exe (
	ECHO Error: ffmpeg is missing.
	ECHO Please, download the complete time lapse toolkit from here:
	ECHO https://github.com/felladrin/windows-timelapse-toolkit/releases
	ECHO Or download it from www.ffmpeg.org and place a copy of 'ffmpeg.exe' in the folder %cd%\lib
	PAUSE
	EXIT /b
)
IF NOT EXIST %cd%\screenshots (
	ECHO No screenshots taken yet.
	PAUSE
	EXIT /b
)
IF NOT EXIST %cd%\videos MKDIR %cd%\videos
FOR /F "tokens=*" %%I IN (config.ini) DO SET %%I
FOR /D %%G IN (screenshots\*) DO (
	(FOR %%i in (%cd%\%%G\*.png) DO @ECHO file '%%i') > screenshots.txt
	IF EXIST %cd%\videos\%%~nG.mp4 (
		ECHO Timelapse video from session %%~nG already exists! Delete it if you want it to be recreated.
	) ELSE (
		ECHO Creating timelapse video from session %%~nG...
		%cd%\lib\ffmpeg.exe -safe 0 -r %TimelapseFramerate% -f concat -i screenshots.txt -loglevel fatal -c:v libx264 -pix_fmt yuv420p -preset %FFmpegPreset% %cd%\videos\%%~nG.mp4
		ECHO Timelapse Video Created! (%cd%\videos\%%~nG.mp4)
	)
	DEL /q screenshots.txt
)
PAUSE