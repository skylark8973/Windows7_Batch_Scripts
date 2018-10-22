@echo off
REG ADD "HKCR\Directory\Background\Shell\Open ST3 Packages Folder\command" /ve /t REG_SZ /d "explorer \"%AppData%\Sublime Text 3\Packages\"" /f
REG ADD "HKCR\Directory\Background\Shell\Open ST3 Packages Folder2\command" /ve /t REG_EXPAND_SZ /d "explorer \"%AppData%\Sublime Text 3\Packages\"" /f
::REG ADD "HKEY_CLASSES_ROOT\Directory\Background\Shell\Open ST3 Packages Folder\command" /ve /t REG_SZ /d "explorer \"%AppData%\Sublime Text 3\Packages\"" /f
::REG ADD "HKEY_CLASSES_ROOT\Directory\Background\Shell\Open ST3 Packages Folder2\command" /ve /t REG_EXPAND_SZ /d "explorer \"%AppData%\Sublime Text 3\Packages\"" /f
pause>nul