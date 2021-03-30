'*******************************************************************
' Имя: StartProcessAdd.vbs
' Язык: VBScript
' Описание: Запуск нового процесса в скрытом окне с высоким приоритетом
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer          ' Имя компьютера
Dim strNamespace         ' Имя пространства имен
Dim objService           ' Объект SWbemServices    
Dim objProcess           ' Объект SWbemObject (класс Win32_Process)
Dim objStartup           ' Объект SWbemObject (класс Win32_ProcessStartup)
Dim objConfig            ' Объект SWbemObject (экземпляр класса
                         '   Win32_ProcessStartup)
Dim intError             ' Значения, возвращаемое методом
Dim intProcessID         ' Идентификатор созданного процесса

' Определяем константы
Const HIDDEN_WINDOW = 12
Const ABOVE_NORMAL = 32768

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)

' Создаем новый экземпляр класса Win32_ProcessStartup
Set objStartup = objService.Get("Win32_ProcessStartup")
Set objConfig = objStartup.SpawnInstance_

' Устанавливаем режим запуска в скрытом окне
objConfig.ShowWindow = HIDDEN_WINDOW
' Устанавливаем приоритет "Выше среднего"
objConfig.PriorityClass = ABOVE_NORMAL

' Создаем ссылку на класс WMI 
Set objProcess = GetObject("WinMgmts:\\" & _
          strComputer & "\" & strNamespace & ":Win32_Process")

' Запускаем метод Create
intError = objProcess.Create _
    ("Notepad.exe", null, objConfig, intProcessID)

' Проверяем возвращенное методом значение
If intError <> 0 Then
  ' Выводим на экран сообщение об ошибке
  WScript.Echo "При создании процесса NOTEPAD.EXE произошла ошибка"
Else
  ' Выводим на экран сообщение об удачном запуске
  WScript.Echo "Процесс NOTEPAD.EXE успешно запущен. "
End If
'************************* Конец ***********************************
