'*******************************************************************
' Имя: ListEvent_Blue_Screen.vbs
' Язык: VBScript
' Описание: Поиск в журнале всех событий краха системы
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
strResult = "События краха системы: " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_ 
                           strComputer & "\" & strNamespace) 
' Создаем коллекцию экземпляров класса Win32_NTLogEvent
Set colEvents = objService.ExecQuery _
    ("SELECT * FROM Win32_NTLogEvent WHERE Logfile = 'System'" _
                              & " and SourceName = 'SaveDump'")
' Перебираем элементы коллекции 
For Each objEvent In colEvents
  ' Формирум строку для вывода на экран 
  strResult = strResult & "  Event date: " &_
              WMIDateStr(objEvent.TimeGenerated) &_
              "  Description: " & objEvent.Message &_
              VbCrLf & VbCrLf
Next

' Выводим результат на экран
Wscript.Echo strResult
'************************* Конец ***********************************
