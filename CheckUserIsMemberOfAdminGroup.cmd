@echo off
set "groupToCheck=BUILTIN\Administrators"
whoami /groups | findstr /B "%groupToCheck:\=\\%\>" >nul 2>&1 && (
  echo I'm in %groupToCheck%
) || (
  echo I'm NOT in %groupToCheck%
)
pause>nul
