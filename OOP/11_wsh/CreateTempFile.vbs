'*******************************************************************
' Имя: CreateTempFile.vbs                                                
' Язык: VBScript                                                   
' Описание: Создание временного файла со случайным именем         
'*******************************************************************
Dim FSO,FileName,F,s  'Объявляем переменные
'Создаем объект FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'Генерируем случайное имя файла
FileName = FSO.GetTempName
'Создаем файл и именем FileName
Set F = FSO.CreateTextFile(FileName, true) 
'Закрываем файл
F.Close
'Сообщаем о создании файла
WScript.Echo "Был создан файл " & FileName
'*************  Конец *********************************************
