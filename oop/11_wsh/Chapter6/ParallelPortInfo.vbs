'*******************************************************************
' Имя: ParallelPortInfo.vbs
' Язык: VBScript
' Описание: Вывод информации о параллельных портах 
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colPorts          ' Коллекция экземпляров класса WMI
Dim objPort           ' Элемент коллекции
Dim strCapability     ' Поддерживаемые режимы порта
Dim strResult         ' Результирующая строка

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_ParallelPort"
strResult = "Информация о параллельных портах:" & vbCrLf & vbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_ParallelPort
Set colPorts = objClass.Instances_

' Перебираем элементы коллекции 
For Each objPort In colPorts
  strResult = strResult & "Availability: " & _
              objPort.Availability & VbCrLf
  For Each strCapability In objPort.Capabilities
    strResult = strResult & "Capability: " & _
                strCapability & VbCrLf
  Next
  strResult = strResult & "Description: " & _
              objPort.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objPort.DeviceID & VbCrLf
  strResult = strResult & "Name: " & _
              objPort.Name & VbCrLf
  strResult = strResult & "OS Auto Discovered: " & _
              objPort.OSAutoDiscovered & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objPort.PNPDeviceID & VbCrLf
  strResult = strResult & "Protocol Supported: " & _
              objPort.ProtocolSupported & VbCrLf
Next

' Выводим результат на экран
Wscript.Echo strResult
'************************* Конец ***********************************
