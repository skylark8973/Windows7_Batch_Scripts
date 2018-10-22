@echo off
set CurrDateTime=%date:~4,2%%date:~7,2%%date:~10,4%_%time:~0,2%%time:~3,2%%time:~6,2%
if [%~1]==[] (
	set /p sourcefile="Provide full path of the file to be copied: "
	echo %sourcefile%
	::set targetfile="%cd%\%~nsourcefile-%CurrDateTime%%~x1"
	pause>nul
)
pause>nul
copy "%cd%\%1" "%cd%\%~n1-%CurrDateTime%%~x1"
exit