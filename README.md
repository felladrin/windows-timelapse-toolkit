# Windows TimeLapse Toolkit

Windows toolkit for taking periodic screenshots and generate a time lapse video from them.

### How to use

- Unzip the folder wherever you want. Screenshots and timelapse videos will be saved inside this folder.
- Double-click '*start-taking-screenshots*'. Then press Ctrl+C when you want to finish taking screenshots.
- Double-click '*create-timelapse-video*'. The more screenshots you have, the longer it'll take to create it.
- Optionally edit the '*config*' file to suit your needs. The default configuration is:
  - Take a screenshot every 30 seconds.
  - Create the timelapse videos displaying 10 screenshots per second.
  - Use [FFmpeg 'veryslow' preset](https://trac.ffmpeg.org/wiki/Encode/H.264#a2.Chooseapreset) to create videos with the smallest possible size.
  - Hide output messages from FFmpeg while creating the videos.
  - Use RBTray to allow minimizing the window to system tray.
- That's it! You'll find your timelapses inside the '*videos*' folder.

### Third-party softwares used

- [FFmpeg](https://github.com/FFmpeg/FFmpeg) (LGPL-licensed with optional components licensed under GPL)
- [RBTray](http://rbtray.sourceforge.net/) (GPL)
- [screenCapture.bat (exe)](https://github.com/npocmaka/batch.scripts/blob/master/hybrids/.net/c/screenCapture.bat)

### Timelapse example on Youtube

[![Time lapse example](https://img.youtube.com/vi/pHccGxY50cU/0.jpg)](https://www.youtube.com/watch?v=pHccGxY50cU)

### Setting it to start taking screenshots on Windows Logon

If you want it to start taking screenshots automatically as soon as you login to Windows, do the following:

Right-click '*start-taking-screenshots*' and select 'Create Shortcut'. A shortcut will be created on the same folder. Then rename it to whatever you want (Suggestion: 'AutoScreenshoter'), and drag&drop it to `Start Menu >> Programs >> Startup`.

Another way to access the the startup folder is through Windows Explorer: Just type on the address bar: `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup` - Then paste the shortcut there.

Done. Next time you restart your computer, the screenshoter will be started automatically.  
It's useful for those who want to keep a videolog of their actions on Windows along the day.
