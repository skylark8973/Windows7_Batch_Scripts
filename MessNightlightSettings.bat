rem rem Disable
rem reg add HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\$$windows.data.bluelightreduction.bluelightreductionstate\Current /v Data /t REG_BINARY /d 0200000088313cdb4584d4010000000043420100d00a02c614dabef0d9dd88a1ea0100 /f
rem rem Enable
rem reg add HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\$$windows.data.bluelightreduction.bluelightreductionstate\Current /v Data /t REG_BINARY /d 02000000d3f1d47c4584d40100000000434201001000d00a02c61487dad3e6d788a1ea0100 /f
rem rem Heavy Reduction
rem reg add HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\$$windows.data.bluelightreduction.settings\Current /v Data /t REG_BINARY /d 02000000e113e4af4784d4010000000043420100c20a00ca140e0900ca1e0e0700cf28f625ca320e142e2b00ca3c0e052e0e0000 /f
rem rem Light Reduction
rem reg add HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\$$windows.data.bluelightreduction.settings\Current /v Data /t REG_BINARY /d 020000006a092c904784d4010000000043420100c20a00ca140e0900ca1e0e0700cf28aa41ca320e142e2b00ca3c0e052e0e0000 /f

Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default$windows.data.bluelightreduction.settings\windows.data.bluelightreduction.settings]
; 4 bytes whatever, CloudStore Signature ?
"Data"=hex:43,42,01,00,\
; Might still be 64 Bit filetime, last time the setting was changed in the control panel
  0a,02,01,00,2a,06,c1,98,\
; 11 bytes whatever
  99,fb,05,2a,2b,0e,1f,43,42,01,00,\
; Acivated flag. It is is missing (i.e. ce,14, is here) is is off!
  02,01,\
; 3 bytes whatever
  ca,14,0e,\
; Starting Hour, 0x13 = 19
  13,\
; A constant
  2e,\
; Starting Minute, 0x39 = 57
  39,\
; 4 bytes whatever
  00,ca,1e,0e,\
; Ending Hour, 0x06 = 6 Uhr
  06,\
; A constant
  2e,\
; Ending Minute
  39,\
; 3 bytes constant
  00,cf,28,\
; Strength, here "33".
  9e,4a,\
; 10 bytes whatever (why so many trailing zeroes?)
  ca,32,00,ca,3c,00,00,00,00,00
