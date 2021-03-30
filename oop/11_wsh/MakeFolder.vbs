'*******************************************************************
' Имя: MakeFolder.vbs                                           
' Язык: VBScript                                                   
' Описание: Создание нового каталога                              
'*******************************************************************
'Объявляем переменные
Dim FSO, F, SubFolders

'Создаем объект FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'Создаем каталог C:\Program Files\Новая папка
FSO.CreateFolder("C:\Program Files\Новая папка")
'Создаем объект Folder для каталога C:\Program Files
Set F = FSO.GetFolder("C:\Program Files")
'Создаем коллекцию подкаталогов каталога C:\Program Files
Set SubFolders = F.SubFolders
'Создаем каталог C:\Program Files\Еще одна новая папка
SubFolders.Add "Еще одна новая папка"
'*************  Конец *********************************************
