'*******************************************************************
' Имя: MonitorEventLog.vbs
' Язык: VBScript
' Описание: Мониторинг журналов событий
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim colEvents         ' Коллекция экземпляров класса WMI
Dim objEvent          ' Элемент коллекции
Dim strResult         ' Результат запроса

' Функция для конвертации даты формата WMI в строку
Function WMIDateStr(WMIDate)
    WMIDateStr = CDate(Mid(WMIDate, 5, 2) & "." & _
         Mid(WMIDate, 7, 2)  & "." &_
         Left(WMIDate, 4)    & " " &_
         Mid(WMIDate, 9, 2)  & ":" & _
         Mid(WMIDate, 11, 2) & ":" & _
         Mid(WMIDate, 13, 2))
End Function

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strResult = ""

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:{(Security)}!\\" &_ 
                           strComputer & "\" & strNamespace) 
' Выполняем запрос для подписки на извещения о событиях WMI 
Set colEvents = objService.ExecNotificationQuery _
         ("SELECT * FROM __InstanceCreationEvent " &_
          "WITHIN 5 WHERE TargetInstance ISA 'Win32_NTLogEvent'")
' Записываем в переменную objEvent следующее событие
Set objEvent = colEvents.NextEvent
' Фомируем строку для вывода на экран
strResult = _
  "Record No.: " & objEvent.TargetInstance.RecordNumber & VbCrLf &_
  "Event ID: " & objEvent.TargetInstance.EventCode & VbCrLf &_
  "Time: " &_
       WMIDateStr(objEvent.TargetInstance.TimeWritten) & VbCrLf &_
  "Source: " & objEvent.TargetInstance.SourceName & VbCrLf &_
  "Category: " & _
               objEvent.TargetInstance.CategoryString & VbCrLf &_
  "Event Type: " & objEvent.TargetInstance.Type & VbCrLf &_
  "Computer: " & objEvent.TargetInstance.ComputerName & VbCrLf &_
  "User: " & objEvent.TargetInstance.User & VbCrLf &_
  "Text: " & objEvent.TargetInstance.Message 
   
' Выводим сообщение на экран
WScript.Echo strResult
'************************* Конец ***********************************
