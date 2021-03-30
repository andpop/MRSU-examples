'********************************************************************
' Имя: DelUserAndGroup.vbs  
' Язык: VBScript                                                    
' Описание: Удаление пользователя и группы компьютера
'********************************************************************
Option Explicit
On Error Resume Next

'Объявляем переменные
Dim objComputer          ' Экземпляр объекта Computer
Dim strUser              ' Имя удаляемого пользователя
Dim strGroup             ' Имя удаляемой группы
Dim WshShell             ' Объект WshShell
Dim strMess              ' 

'********************** Начало *************************************
' Имя удаляемого пользователя
strUser = "XUser"    
' Имя удаляемой группы
strGroup = "XGroup"  

' Связываемся с компьютером Popov
Set objComputer = GetObject("WinNT://Popov")
' Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

'*************  Удаление пользователя  ***********************
' Удаляем пользователя
objComputer.Delete "user", strUser

' Обрабатываем ошибки
If Err.Number <> 0 Then  
  strMess="Ошибка при удалении пользователя " & strUser & vbCrLf & _
       "Код ошибки: " & Err.number & "Описание: " & Err.description
  WshShell.Popup strMess,0,"Удаление пользователя",vbCritical

  ' Очищаем свойства объекта Err
  Err.Clear
Else
  ' Все в порядке
  strMess = "Пользователь " & strUser & " удален"
  WshShell.Popup strMess,0,"Удаление пользователя",vbInformation
End If

'*************  Удаление группы  ***********************/
objComputer.Delete "group", strGroup

' Обрабатываем ошибки
If Err.Number <> 0 Then  
  strMess="Ошибка при удалении группы " & strGroup & vbCrLf & _
       "Код ошибки: " & Err.number & "Описание: " & Err.description
  ' Очищаем свойства объекта Err
  Err.Clear
Else
  ' Все в порядке
  strMess="Группа " & strGroup & " удалена"
  WshShell.Popup strMess,0,"Удаление группы",vbInformation
End If
'*************  Конец *********************************************/
