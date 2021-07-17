@echo off
TASKKILL /F /T /IM Chrome.exe /IM Chrome-Proxy.exe /IM Sublime_Text.exe /IM Teams.exe /IM Slack.exe
TASKKILL /F /IM Explorer.exe & START Explorer.exe
TASKKILL /F /IM Explorer.exe && START Explorer.exe
