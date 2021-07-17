@echo off
for /f "tokens=*" %%i in ('powercfg -q ^| find "Power Scheme GUID"') do set pwrSchm=%%i
set pwrSchm=%pwrSchm:~19,36%

for /f "tokens=*" %%i in ('powercfg -q ^| find "(Display)"') do set dsply=%%i
set dsply=%dsply:~15,36%

for /f "tokens=*" %%i in ('powercfg -q ^| find "(Display brightness)"') do set brtnss=%%i
set brtnss=%brtnss:~20,36%

set /p brightness="Enter desired brightness value: "

set AcDc=Dc
WMIC /NameSpace:\\root\WMI Path BatteryStatus Get PowerOnline | find /i "true" > nul && set AcDc=Ac

powercfg -Set%AcDc%ValueIndex %pwrSchm% %dsply% %brtnss% %brightness%
powercfg -S %pwrSchm%
