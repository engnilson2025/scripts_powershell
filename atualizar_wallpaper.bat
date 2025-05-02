@echo off
setlocal

REM Configurações
set "DOWNLOAD_DIR=%TEMP%"
set "IMG_NAME=wallpaper.jpg"
set "IMG_URL=https://drive.google.com/uc?export=download&id=171Lt7GApFBfHCp3P7_KKgM73AyPcZSgr"

REM Baixa a imagem com PowerShell
powershell -Command "Invoke-WebRequest -Uri '%IMG_URL%' -OutFile '%DOWNLOAD_DIR%\%IMG_NAME%'"

REM Define como papel de parede
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%DOWNLOAD_DIR%\%IMG_NAME%" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

echo Papel de parede atualizado com sucesso!
pause
