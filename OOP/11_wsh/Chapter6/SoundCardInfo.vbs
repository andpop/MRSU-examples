'*******************************************************************
' Имя: SoundCardInfo.vbs
' Язык: VBScript
' Описание: Вывод информации о звуковой карте
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colSoundCards     ' Коллекция экземпляров класса WMI
Dim objSoundCard      ' Элемент коллекции
Dim strResult         ' Результирующая строка

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_SoundDevice"
strResult = "Информация о звуковой карте:" & vbCrLf & vbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_SoundDevice
Set colSoundCards = objClass.Instances_

' Перебираем элементы коллекции 
For Each objSoundCard in colSoundCards
  strResult = strResult & "Description: " & _
              objSoundCard.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objSoundCard.DeviceID & VbCrLf
  strResult = strResult & "DMA Buffer Size: " & _
              objSoundCard.DMABufferSize & VbCrLf
  strResult = strResult & "Manufacturer: " & _
              objSoundCard.Manufacturer & VbCrLf
  strResult = strResult & "MPU 401 Address: " & _
              objSoundCard.MPU401Address & VbCrLf
  strResult = strResult & "Name: " & _
              objSoundCard.Name & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objSoundCard.PNPDeviceID & VbCrLf
  strResult = strResult & "Product Name: " & _
              objSoundCard.ProductName & VbCrLf
  strResult = strResult & "Status Information: " & _
              objSoundCard.StatusInfo & VbCrLf
Next

' Выводим результат на экран
Wscript.Echo strResult
'************************* Конец ***********************************
