$wallpaperDir = "C:\wallpaper"
if (-not (Test-Path $wallpaperDir)) { New-Item -Path $wallpaperDir -ItemType Directory }

$imageUrl = "https://drive.google.com/uc?export=download&id=171Lt7GApFBfHCp3P7_KKgM73AyPcZSgr"
$imagePath = "$wallpaperDir\wallpaper.jpg"
$scriptPath = "$wallpaperDir\mudar-wallpaper.ps1"

$psContent = @'
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=171Lt7GApFBfHCp3P7_KKgM73AyPcZSgr" -OutFile "C:\wallpaper\wallpaper.jpg"
Add-Type 'using System.Runtime.InteropServices; public class NativeMethods { [DllImport("user32.dll", SetLastError = true)] public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }'
[NativeMethods]::SystemParametersInfo(20, 0, "C:\wallpaper\wallpaper.jpg", 0x01 -bor 0x02)
'@

Set-Content -Path $scriptPath -Value $psContent -Force

$escapedArgs = '-ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\wallpaper\mudar-wallpaper.ps1"'
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $escapedArgs
$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -UserId "Aluno" -LogonType Interactive
Register-ScheduledTask -TaskName "AtualizarWallpaperAluno" -Action $action -Trigger $trigger -Principal $principal -Force
