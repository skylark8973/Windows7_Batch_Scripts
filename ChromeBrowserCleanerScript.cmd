<# ::
@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1

SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS

TASKKILL.EXE /F /T /IM chrome.exe /IM chrome_proxy.exe & POWERSHELL -NoProfile -NoLogo "iex (${%~f0} | out-string)"

SET ChromeStartDir="%ProgramFiles%\Google\Chrome\Application"
SET ChromeAppProxyDir="%ProgramFiles%\Google\Chrome\Application"
PUSHD %ChromeStartDir% && START chrome.exe --user-data-dir="C:/ChromeSafePluginsTmp" --safe-plugins ^
--enable-features=PasswordImport && POPD
TASKKILL /F /IM conhost.exe cmd.exe bash.exe /T
EXIT 0
#>

#------------------------------------------------------------------#
#- Clear-ChromeCache                                               #
#------------------------------------------------------------------#
Function Clear-ChromeCache {
    Param
    (
        [string] $user = $env:USERNAME,
        [string] $chromeAppData = "C:\ChromeSafePluginsTmp",
        [string] $chromeDataDir = "C:\ChromeSafePluginsTmp\Default"
        # [Parameter(Mandatory=$true, Position=0)] [string] $user = $env:USERNAME,
        # [Parameter(Mandatory=$true, Position=1)] [string] $chromeAppData = "C:\ChromeSafePluginsTmp",
        # [Parameter(Mandatory=$true, Position=2)] [string] $chromeDataDir = "C:\ChromeSafePluginsTmp\Default"

    )
    if((Test-Path $chromeDataDir))
    {
        $possibleCachePaths = @('Cache','Cache2\entries\','Cookies','History' `
            ,'Top Sites','VisitedLinks','Web Data','Media Cache','Cookies-Journal' `
            ,'ChromeDWriteFontCache')
        ForEach($cachePath in $possibleCachePaths)
        {
            Remove-CacheFiles "$chromeDataDir\$cachePath"
        }
    }
}

#------------------------------------------------------------------#
#- Remove-CacheFiles                                               #
#------------------------------------------------------------------#
Function Remove-CacheFiles {
    param([Parameter(Mandatory=$true)][string]$path)
    BEGIN
    {
        $originalVerbosePreference = $VerbosePreference
        $VerbosePreference = 'Continue'
    }
    PROCESS
    {
        if((Test-Path $path))
        {
            if([System.IO.Directory]::Exists($path))
            {
                try
                {
                    if($path[-1] -eq '\')
                    {
                        [int]$pathSubString = $path.ToCharArray().Count - 1
                        $sanitizedPath = $path.SubString(0, $pathSubString)
                        Remove-Item -Path "$sanitizedPath\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
                    }
                    else
                    {
                        Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
                    }
                } catch { }
            }
            else
            {
                try
                {
                    Remove-Item -Path $path -Force -ErrorAction SilentlyContinue -Verbose
                } catch { }
            }
        }
    }
    END
    {
        $VerbosePreference = $originalVerbosePreference
    }
}

Clear-ChromeCache

::"C:\Program Files\Google\Chrome\Application\chrome_proxy.exe" --user-data-dir="C:\ChromeSafePluginsTmp" --profile-directory=Default --app-id=faolnafnngnfdaknnbpnkhgohbobgegn
::"C:\Program Files\Google\Chrome\Application\chrome_proxy.exe" --user-data-dir="C:\ChromeSafePluginsTmp" --profile-directory=Default --app-id=ocdlmjhbenodhlknglojajgokahchlkk
