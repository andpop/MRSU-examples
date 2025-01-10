'*******************************************************************
' Имя: ListSubFold.vbs                                             
' Язык: VBScript                                                   
' Описание: Получение списка всех подкаталогов заданного каталога 
'*******************************************************************
'Объявляем переменные
Dim FSO,F,SFold,SubFolders,Folder,s

'Создаем объект FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'Путь к каталогу
SFold = "C:\Program Files"
s = "Каталог " & SFold & VbCrLf
s = s & "Подкаталоги:" & VbCrLf
'Создаем объект Folder для каталога C:\Program Files
Set F=FSO.GetFolder(SFold)

'Создаем коллекцию подкаталогов каталога C:\Program Files
Set SubFolders = F.SubFolders

'Цикл по всем подкаталогам
For Each Folder In SubFolders
  'Добавляем строку с именем подкаталога
   s = s & Folder & VbCrLf
Next

'Выводим полученные строки на экран
WScript.Echo s
'*************  Конец *********************************************/
