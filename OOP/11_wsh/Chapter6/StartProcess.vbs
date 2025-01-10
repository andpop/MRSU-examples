'*******************************************************************
' Имя: StartProcess.vbs
' Язык: VBScript
' Описание: Запуск нового процесса
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса
Dim objClass          ' Класс WMI
Dim intError          ' Значения, возвращаемое методом
Dim intProcessID      ' Идентификатор созданного процесса

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "Shikin"
strNamespace = "Root\CIMV2"
strClass = "Win32_Process"

' Создаем ссылку на класс WMI 
Set objClass = GetObject("WinMgmts:" & _
     "{impersonationLevel=impersonate}!\\" &_
     strComputer & "\" & strNamespace & ":" & strClass)

' Запускаем метод Create
intError = objClass.Create("Notepad.exe", null, null, intProcessID)

' Проверяем возвращенное методом значение
If intError <> 0 Then
  ' Выводим на экран сообщение об ошибке
  WScript.Echo "При создании процесса NOTEPAD.EXE произошла ошибка"
Else
  ' Выводим на экран сообщение об удачном запуске
  WScript.Echo "Процесс NOTEPAD.EXE успешно запущен. " 
End If
'************************* Конец ***********************************
