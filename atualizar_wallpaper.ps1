$imageUrl = "https://drive.google.com/uc?export=download&id=171Lt7GApFBfHCp3P7_KKgM73AyPcZSgr"
$imagePath = "$env:TEMP\wallpaper.jpg"

# Baixar imagem
Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath

# Confirmar que foi baixado
if (-Not (Test-Path $imagePath)) {
    Write-Output "Download da imagem falhou."
    exit 1
}

# Função para aplicar papel de parede
Add-Type @"
using System.Runtime.InteropServices;
public class NativeMethods {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Flags: 0x01 = Update INI file | 0x02 = Send change
$success = [NativeMethods]::SystemParametersInfo(20, 0, $imagePath, 0x01 -bor 0x02)

if ($success) {
    Write-Output "✅ Papel de parede atualizado com sucesso!"
} else {
    Write-Output "❌ Falha ao aplicar papel de parede."
}
