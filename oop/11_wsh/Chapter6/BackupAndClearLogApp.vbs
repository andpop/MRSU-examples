'*******************************************************************
' Имя: BackupAndClearLogApp.vbs
' Язык: VBScript
' Описание: Резервирование и очистка журнала событий приложений
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim colLogFiles       ' Коллекция экземпляров класса WMI
Dim objLogFile        ' Элемент коллекции
Dim iError            ' Значение, возвращаемое методом

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:{(Backup)}\\" &_ 
                            strComputer & "\" & strNamespace) 
' Создаем коллекцию экземпляров класса Win32_NTEventLogFile
Set colLogFiles = objService.ExecQuery _
    ("SELECT * FROM Win32_NTEventLogFile WHERE LogFileName='Application'")
    
' Перебираем элементы коллекции 
For Each objLogFile In colLogFiles
  ' Резервируем журнал событий приложений в файле c:\application.evt
  iError = objLogFile.BackupEventLog("c:\application.evt")
  ' Обрабатываем ошибки, возвращенные методом BackupEventLog
  If iError <> 0 Then        
    ' Выводим сообщение об ошибке
    Wscript.Echo "Журнал событий приложений не может быть сохранен."
  Else
    ' Очищаем журнал событий приложений
    iError = objLogFile.ClearEventLog()
    ' Обрабатываем ошибки, возвращенные методом ClearEventLog
    If iError <> 0 Then 
      ' Выводим сообщение об ошибке
      Wscript.Echo "Журнал событий приложений не может быть очищен."
    Else
      ' Выводим сообщение об успешном выполнении
      Wscript.Echo "Журнал событий приложений сохранен и очищен."        
    End If
  End If
Next
'************************* Конец ***********************************
