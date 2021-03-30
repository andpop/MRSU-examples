'******************************************************************
' Имя: IsExistsFile.vbs                                            
' Язык: VBScript                                                   
' Описание: Проверка существования файла                          
'*******************************************************************
Dim FSO,FileName 'Объявляем переменные

'Создаем объект FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")

FileName = "C:\boot.ini"
if  FSO.FileExists(FileName)  Then
  'Выводим информацию на экран
  WScript.Echo "Файл " & FileName & " существует"
else
  'Выводим информацию на экран
  WScript.Echo "Файл " & FileName & " не существует" 
end if
'*************  Конец *********************************************
