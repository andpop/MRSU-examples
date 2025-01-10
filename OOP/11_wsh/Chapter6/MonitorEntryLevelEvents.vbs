'*******************************************************************
' Имя: MonitorEntryLevelEvents.vbs
' Язык: VBScript
' Описание: Мониторинг изменений в параметре реестра 
'*******************************************************************
 Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен WMI
Dim objService        ' Объект SWbemServices    
Dim objSink           ' Объект SWbemSink
Dim bDone             ' Переменная-флаг выхода из цикла

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."

' Подключаемся к пространству имен \Root\Default
Set objService = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default") 
' Создаем объект SWbemSink
Set objSink = WScript.CreateObject("WbemScripting.SWbemSink", "SINK_") 

' Выполняем запрос для подписки на извещения о событиях изменения
' значения параметра SOFTWARE\Example key\Example String Value
objService.ExecNotificationQueryAsync objSink, _ 
    "SELECT * FROM RegistryValueChangeEvent WHERE " &_
    "Hive='HKEY_LOCAL_MACHINE' AND " &_
    "KeyPath='SOFTWARE\\Example key' AND " &_
    "ValueName='Example String Value'" 

' Выводим сообщение о запуске сканера
WScript.Echo "Запущен сканер изменений в параметре реестра" & vbCrLf 

' Приостановливаем сценарий до наступления события
While Not bDone    
  WScript.Sleep 1000
Wend


' Процедура - обработчик события OnObjectReady объекта SWbemSink
Sub Sink_OnObjectReady(oOutParams, oContext)
  ' Выводим сообщение о произошедшем событии
    Wscript.Echo "Произошли изменения в параметре реестра" & vbCrLf & _ 
     "------------------------------" & vbCrLf & _
     oOutParams.GetObjectText_() 
  bDone = True
End Sub            
'************************* Конец ***********************************
