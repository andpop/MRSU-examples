'*******************************************************************
' Имя: ListAllEventsWithCode.vbs
' Язык: VBScript
' Описание: Вывод всех записей с кодом 7036 из журнала событий системы 
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim QueryDate         ' Запрашиваемая дата
Dim objService        ' Объект SWbemService
Dim colEvents         ' Коллекция экземпляров класса WMI
Dim objEvent          ' Элемент коллекции
Dim strResult         ' Результат запроса
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

' Объявляем константы
Const ForWriting = 2

' Процедура для записи информации в файл 
Sub TextOut (Text, File)
  ' Объявляем переменные
  Dim  objFSO, FOut 
  ' Создаем объект FileSystemObject
  Set  objFSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' Открываем выходной файл для записи
  Set  FOut = objFSO.OpenTextFile (File,ForWriting,true)
  ' Записываем текстовую строку в файл
  FOut.WriteLine Text
  ' Закрываем выходной файл
  FOut.Close
End Sub

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
strResult = "События журнала :" & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_ 
                           strComputer & "\" & strNamespace) 
' Создаем коллекцию экземпляров класса Win32_NTLogEvent
Set colEvents = objService.ExecQuery _
    ("SELECT * FROM Win32_NTLogEvent WHERE (Logfile ='System')" &_
    " and (EventCode = '7036')")
    
' Перебираем элементы коллекции     
For Each objEvent in colEvents
  ' Формируем строку для вывода файл  
  strResult = strResult & VbCrLf &_ 
              "  Logfile: " & objEvent.Logfile & VbCrLf &_ 
      VbTab & "  Category: " & objEvent.Category & VbCrLf &_ 
      VbTab & "  Computer Name: " & objEvent.ComputerName & VbCrLf &_ 
      VbTab & "  Event Code: " & objEvent.EventCode & VbCrLf &_ 
      VbTab & "  Message: " & objEvent.Message &_ 
      VbTab & "  Record Number: " & objEvent.RecordNumber & VbCrLf &_ 
      VbTab & "  Source Name: " & objEvent.SourceName & VbCrLf &_ 
      VbTab & "  Time Written: " &_
                 WMIDateStr(objEvent.TimeWritten) & VbCrLf &_ 
      VbTab & "  Event Type: " & objEvent.Type & VbCrLf &_ 
      VbTab & "  User: " & objEvent.User & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\ListEvent.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\ListEvent.txt" )
'************************* Конец ***********************************
