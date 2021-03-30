'*******************************************************************
' Имя: PreventProcess.vbs
' Язык: VBScript
' Описание: Авоматическое закрытие открываемого Блокнота 
'*******************************************************************
 Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен WMI
Dim objService        ' Объект SWbemServices    
Dim objEventSource    ' Объект SWbemEventSource
Dim objEvent          ' Объект SWbemObject 
Dim strResult         ' Результирующая строка

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
' Выполняем запрос для подписки на извещения о событиях WMI 
Set objEventSource = objService.ExecNotificationQuery _
            ("SELECT * FROM __InstanceCreationEvent " & _
             "WITHIN 5 WHERE (TargetInstance ISA 'Win32_Process' " &_
              "AND TargetInstance.Name='NOTEPAD.EXE') ")

' Выводим сообщение о запуске сканера
Wscript.Echo " Запущен убийца Блокнотов"

Do While true
  ' Записываем в переменную objEvent следующее событие
  Set objEvent = objEventSource.NextEvent

  'Завершаем работу процесса objEvent.TargetInstance
  objEvent.TargetInstance.Terminate
Loop
'************************* Конец ***********************************
