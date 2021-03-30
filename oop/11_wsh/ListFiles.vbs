'*******************************************************************
' Имя: ListFiles.vbs                                               
' Язык: VBScript                                                   
' Описание: Получение списка всех файлов заданного каталога       
'*******************************************************************
'Объявляем переменные
Dim FSO,F,File,Files,WshShell,PathList,s

'Создаем объект FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'Создаем объект WshShell
Set WshShell = WScript.CreateObject("Wscript.Shell")
'Создаем объект WshSpecialFolders
Set WshFldrs = WshShell.SpecialFolders
'Определяем путь к папке "Мои документы"
PathList = WshFldrs.item("MyDocuments") & "\"
'Создаем объект Folder для папки "Мои документы"
Set F = FSO.GetFolder(PathList)
'Создаем коллекцию файлов каталога "Мои документы"
Set Files = F.Files
s = "Файлы из каталога " & PathList & VbCrLf
'Цикл по всем файлам
For Each File In Files
  'Добавляем строку с именем файла
  s = s & File.Name & VbCrLf
Next

'Выводим полученные строки на экран
WScript.Echo s
'*************  Конец *********************************************
