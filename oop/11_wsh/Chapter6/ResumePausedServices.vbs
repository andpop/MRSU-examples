'*******************************************************************
' Имя: ResumePausedServices.vbs
' Язык: VBScript
' Описание: Продолжение работы приостановленных служб 
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objWMIService     ' Объект SWbemServices    
Dim colServices       ' Коллекция экземпляров класса WMI
Dim objService        ' Элемент коллекции
Dim strResult         ' Результирующая строка
Dim WshShell          ' Объект WshShell
Dim Res               

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен WMI
Set objWMIService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
' Формируем коллекцию остановленных служб 
Set colServices = objWMIService.ExecQuery _
("SELECT * FROM Win32_Service WHERE State = 'Paused' and StartMode = " _
 & "'Auto'")

' Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

' Запрос на запуск служб
Res = WshShell.Popup("Возобновить работу всех приостановленных служб?"_
  ,0, "Работа со службами Windows",vbQuestion+vbYesNo)
If Res=vbYes Then
  ' Возобновляем каждую приостановленную службу         
  For Each objService In colServices
    objService.ResumeService()
  Next
  WScript.Echo "Работа всех приостановленных служб возобновлена"
End If  
'************************* Конец ***********************************
