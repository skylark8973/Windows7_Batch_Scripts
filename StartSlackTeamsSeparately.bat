set SlackAppPath=%LocalAppData%\slack\slack.exe
set SlackRunPath=%LocalAppData%\slack\app-4.17.1
:: Teams run command: %LocalAppData%\Microsoft\Teams\Update.exe --processStart "Teams.exe"
set TeamsAppPath=%LocalAppData%\Microsoft\Teams\Update.exe
set TeamsRunPath=%LocalAppData%\Microsoft\Teams
taskkill /f /t /im ssh-agent.exe /im git-bash.exe /im sh.exe /im slack.exe /im Teams.exe
pushd %SlackRunPath% && start "" /B slack.exe && popd
pushd %TeamsRunPath% && start "" /B Update.exe --processStart "Teams.exe" && popd
