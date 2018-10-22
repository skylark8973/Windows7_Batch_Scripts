@echo off
cd %ProgramFiles%\Windows Defender
::MpCmdRun.exe -removedefinitions -dynamicsignatures
MpCmdRun.exe -SignatureUpdate
MSASCui.exe -UpdateAndQuickScan
pause>nul