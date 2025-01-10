'*******************************************************************
' Имя: MouseInfo.vbs
' Язык: VBScript
' Описание: Вывод информации о мыши 
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colMice           ' Коллекция экземпляров класса WMI
Dim objMouse          ' Элемент коллекции
Dim strResult         ' Результирующая строка

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_PointingDevice"
strResult = "Информация о мыши:" & vbCrLf & vbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_PointingDevice
Set colMice = objClass.Instances_

' Перебираем элементы коллекции 
For Each objMouse In colMice
  strResult = strResult & "Hardware Type: " & _
              objMouse.HardwareType & VbCrLf
  strResult = strResult & "Number of Buttons: " & _
              objMouse.NumberOfButtons & VbCrLf
  strResult = strResult & "Status: " & objMouse.Status & VbCrLf
  strResult = strResult & "PNP Device ID: " & objMouse.PNPDeviceID
Next

' Выводим результат на экран
Wscript.Echo strResult
'************************* Конец ***********************************
