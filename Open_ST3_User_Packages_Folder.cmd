@echo off
REG ADD "HKCR\Directory\Background\Shell\Open ST3 User Packages Folder\command" /ve /t REG_SZ /d "explorer \"%AppData%\Sublime Text 3\Packages\User\"" /f
pause>nul