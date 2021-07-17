@echo off
FOR /L %%X IN (1,1,10) DO (
    TASKKILL /F /IM Chrome.exe /IM GoogleCrashHandler.exe /IM GoogleCrashHandler64.exe /IM chrome_proxy.exe /T
)
SET ChromeStartDir="%ProgramFiles%\Google\Chrome\Application"
SET ChromeAppProxyDir="%ProgramFiles%\Google\Chrome\Application"
PUSHD %ChromeStartDir% && START chrome.exe && POPD
::PUSHD %ChromeStartDir% && START chrome.exe --disable-extensions && POPD
