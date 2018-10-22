' Dim sh : Set sh = CreateObject("WScript.Shell")
' Set Rtn = sh.Exec("SystemPropertiesAdvanced.exe")
' WScript.Sleep 1000
' MsgBox "my App PID : "& Rtn.ProcessID

set process = GetObject("winmgmts:Win32_Process")
result = process.Create("SystemPropertiesAdvanced.exe", null, null, processid)
MsgBox "my App PID : "&result