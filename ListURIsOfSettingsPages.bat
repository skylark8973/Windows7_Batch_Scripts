@For /f "tokens=1* delims=" %%A in ('reg query HKCR /f "URL:*" /s /d ^| findstr /c:"URL:ms-settings" ^| findstr /v /c:"URL: " ^| Sort') Do @Echo %%A %%B
pause
