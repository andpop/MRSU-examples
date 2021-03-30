'*******************************************************************
' Имя: MemoryInfo.vbs
' Язык: VBScript
' Описание: Вывод информации о физической памяти
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colPhysMemory     ' Коллекция экземпляров класса WMI
Dim objPhysMemory     ' Элемент коллекции
Dim strResult         ' Результирующая строка

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_PhysicalMemory"
strResult = "Информация о физической памяти:" & vbCrLf & vbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_PhysicalMemory
Set colPhysMemory = objClass.Instances_

' Перебираем коллекцию
For Each objPhysMemory In colPhysMemory
  strResult = strResult & "Bank Label: " & _
              objPhysMemory.BankLabel & VbCrLf
  strResult = strResult & "Capacity: " & _
              objPhysMemory.Capacity & VbCrLf
  strResult = strResult & "Data Width: " & _
              objPhysMemory.DataWidth & VbCrLf
  strResult = strResult & "Description: " & _
              objPhysMemory.Description & VbCrLf
  strResult = strResult & "Device Locator: " & _
              objPhysMemory.DeviceLocator & VbCrLf
  strResult = strResult & "Form Factor: " & _
              objPhysMemory.FormFactor & VbCrLf
  strResult = strResult & "Hot Swappable: " & _
              objPhysMemory.HotSwappable & VbCrLf
  strResult = strResult & "Manufacturer: " & _
              objPhysMemory.Manufacturer & VbCrLf
  strResult = strResult & "Memory Type: " & _
              objPhysMemory.MemoryType & VbCrLf
  strResult = strResult & "Name: " & _
              objPhysMemory.Name & VbCrLf
  strResult = strResult & "Part Number: " & _
              objPhysMemory.PartNumber & VbCrLf
  strResult = strResult & "Speed: " & _
              objPhysMemory.Speed & VbCrLf
  strResult = strResult & "Tag: " & _
              objPhysMemory.Tag & VbCrLf
  strResult = strResult & "Type Detail: " & _
              objPhysMemory.TypeDetail & VbCrLf
Next

' Выводим результат на экран
Wscript.Echo strResult
'************************* Конец ***********************************
