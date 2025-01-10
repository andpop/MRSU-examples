'*******************************************************************
' Имя: MonitorNotepadRun.vbs
' Язык: VBScript
' Описание: Мониторинг запуска Блокнота 
'*******************************************************************
 Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен WMI
Dim objService        ' Объект SWbemServices    
Dim objEventSource    ' Объект SWbemEventSource
Dim objEvent          ' Объект SWbemObject 
Dim strResult         ' Результирующая строка

' Константа для задания режима открытия файла
Const ForAppend = 8

' Процедура для записи информации в файл 
Sub TextOut (Text, File)
  ' Объявляем переменные
  Dim  FSO, FOut 
  ' Создаем объект FileSystemObject
  Set  FSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' Открываем выходной файл для записи
  Set  FOut = FSO.OpenTextFile (File,ForAppend,true)
  ' Записываем текстовую строку в файл
  FOut.WriteLine Text
  ' Закрываем выходной файл
  FOut.Close
End Sub

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
Wscript.Echo " Выполняется сканер запуска Блокнота"

' Записываем в переменную objEvent следующее событие
Set objEvent = objEventSource.NextEvent

' Формирум строку для вывода        
strResult = "Блокнот запущен " & Date & " в " & Time
    
' Выводим результат на экран
WScript.Echo strResult
           
' Выводим результат в текстовый файл
TextOut  "*****************************" & vbCrLf & strResult &_
         "*****************************", "C:\LogNotepad.txt" 
'************************* Конец ***********************************
