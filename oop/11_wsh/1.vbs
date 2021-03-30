set wnet = CreateObject("WScript.Network")
uname = wnet.UserName
MsgBox "Ваше имя пользователя: " & uname
