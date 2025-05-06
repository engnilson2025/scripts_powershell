' Definir variáveis
Dim objXMLHttp, objFSO, objShell, imgURL, imgPath

' Configurações do script
imgURL = "https://drive.google.com/uc?export=download&id=171Lt7GApFBfHCp3P7_KKgM73AyPcZSgr"
imgPath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%TEMP%") & "\wallpaper.jpg"

' Criar objetos
Set objXMLHttp = CreateObject("MSXML2.XMLHTTP")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

' Baixar a imagem com HTTP
objXMLHttp.Open "GET", imgURL, False
objXMLHttp.Send

' Salvar a imagem no diretório temporário
If objXMLHttp.Status = 200 Then
    Set objFile = objFSO.CreateTextFile(imgPath, True)
    objFile.Write(objXMLHttp.ResponseBody)
    objFile.Close
End If

' Definir como papel de parede para o usuário atual
objShell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", imgPath
objShell.Run "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters"

' Mensagem de sucesso
WScript.Echo "Papel de parede atualizado com sucesso!"

' Liberar objetos
Set objXMLHttp = Nothing
Set objFSO = Nothing
Set objShell = Nothing
