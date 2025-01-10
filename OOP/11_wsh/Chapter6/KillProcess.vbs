'*******************************************************************
' Имя: KillProcess.vbs
' Язык: VBScript
' Описание: Завершение запущенного процесса
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemServices    
Dim colProcesses      ' Коллекция экземпляров класса WMI
Dim objProcess        ' Элемент коллекции
Dim WshShell          ' Объект WshShell
Dim Res

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

' Формируем коллекцию процессов NOTEPAD.EXE
Set colProcesses = objService.ExecQuery(_
           "SELECT * FROM Win32_Process WHERE Name='NOTEPAD.EXE'")

'Запрос на завершение работы всех Блокнотов
Res=WshShell.Popup("Завершить работу всех Блокнотов?",0,_
  "Работа с процессами",vbQuestion+vbYesNo)
' Проверяем введенное значение
If Res=vbYes Then
  'Перебираем коллекцию
  For Each objProcess in colProcesses
    ' Завершаем приложение
    objProcess.Terminate()
  Next
End If
'************************* Конец ***********************************
