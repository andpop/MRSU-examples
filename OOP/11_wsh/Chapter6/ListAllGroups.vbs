'********************************************************************
' Имя: ListAllGroups.vbs
' Язык: JScript
' Описание: Вывод на экран имен всех групп заданного компьютера 
'********************************************************************
Option Explicit

'Объявляем переменные
Dim objComputer    ' Экземпляр объекта Computer
Dim objGroup       ' Экземпляр объекта Group
Dim strResult      ' Строка для вывода на экран

'********************** Начало *************************************
' Связываемся с компьютером Popov
Set objComputer = GetObject("WinNT://Popov")

strResult = "На компьютере Popov созданы группы:" & vbCrLf  & vbCrLf

' Перебираем элементы коллекции 
For Each objGroup In objComputer
  ' Выделяем объекты класса Group
  If objGroup.Class = "Group" Then
    'Формируем строку с именами групп
    strResult = strResult & objGroup.Name & vbCrLf
  End If
Next
    
'Выводим информацию на экран
WScript.Echo strResult
'*************  Конец *********************************************/
