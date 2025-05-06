# Criação do diretório onde o script será salvo
$wallpaperDir = "C:\wallpaper"
if (-not (Test-Path -Path $wallpaperDir)) {
    New-Item -Path $wallpaperDir -ItemType Directory
}

# Definindo o caminho do script
$scriptPath = "$wallpaperDir\mudar-wallpaper.ps1"

# Criando o script PowerShell que fará o download e definirá o wallpaper
$scriptContent = @"
$imageUrl = "https://drive.google.com/uc?export=download&id=171Lt7GApFBfHCp3P7_KKgM73AyPcZSgr"
$imagePath = "C:\wallpaper\wallpaper.jpg"

Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath

Add-Type @"
using System.Runtime.InteropServices;
public class NativeMethods {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

[NativeMethods]::SystemParametersInfo(20, 0, $imagePath, 0x01 -bor 0x02)
"@

# Salvando o script no diretório
$scriptContent | Out-File -FilePath $scriptPath -Force

# Criando a tarefa agendada para rodar no login do usuário 'Aluno'
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File $scriptPath"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -UserId "Aluno" -LogonType Interactive

# Registrando a tarefa agendada
Register-ScheduledTask -TaskName "AtualizarWallpaperAluno" -Action $action -Trigger $trigger -Principal $principal -Force

Write-Host "Tarefa agendada com sucesso! A tarefa será executada quando o usuário Aluno fizer login."
