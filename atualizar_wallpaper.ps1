# Caminho da imagem
$downloadDir = $env:TEMP
$imgName = "wallpaper.jpg"
$imgPath = Join-Path $downloadDir $imgName
$imgUrl = "https://drive.google.com/uc?export=download&id=171Lt7GApFBfHCp3P7_KKgM73AyPcZSgr"

# Baixar a imagem
Invoke-WebRequest -Uri $imgUrl -OutFile $imgPath

# Definir como papel de parede
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $imgPath

# Atualizar a configuração do sistema
Add-Type @"
using System.Runtime.InteropServices;
public class NativeMethods {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
[NativeMethods]::SystemParametersInfo(20, 0, $imgPath, 3)

Write-Output "Papel de parede atualizado com sucesso!"

