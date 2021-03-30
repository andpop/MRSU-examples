'*******************************************************************
' Имя: MonitorFileCreation.vbs
' Язык: VBScript
' Описание: Подписка на события создания файла в папке C:\TEST 
'           в асинхронном режиме 
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен WMI
Dim objService        ' Объект SWbemServices    
Dim strResult         ' Результат запроса
Dim objSink           ' Объект SWbemSink
Dim bDone             ' Переменная-флаг выхода из цикла

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен
Set objService = GetObject("WinMgmts:\\" & _
                            strComputer & "\" & strNamespace)
' Создаем объект SWbemSink
Set objSink = wscript.CreateObject("WbemScripting.SWbemSink", "Sink_")

' Выполняем метод ExecMethodAsync_
objService.ExecNotificationQueryAsync objSink, _
       "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE " &_
       "Targetinstance ISA 'CIM_DirectoryContainsFile' and " &_
       "TargetInstance.GroupComponent= " &_
       "'Win32_Directory.Name=""C:\\\\TEST""'"

' Выводим сообщение о запуске сканера
Wscript.Echo " Запущен сканер создания файла в папке C:\TEST"

' Приостановливаем сценарий до завершения выполнения запроса
While Not bDone    
  WScript.Sleep 1000
Wend

' Процедура - обработчик события OnObjectReady объекта sWbemSink
Sub Sink_OnObjectReady(oOutParams, oContext)
  ' Формирум строку для вывода        
  strResult = Date & " " & Time & vbCrLf &_
  "Создан файл: " &  oOutParams.TargetInstance.PartComponent
    
  ' Выводим результат на экран
  Wscript.Echo strResult

  bDone = True         
End Sub
'************************* Конец ***********************************
