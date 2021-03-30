'*******************************************************************
' Имя: Keyboard.vbs
' Язык: VBScript
' Описание: Вывод информации о клавиатуре
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colKeyboards      ' Коллекция экземпляров класса WMI
Dim objKeyboard       ' Элемент коллекции
Dim strResult         ' Результирующая строка

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = " _Keyboard"
strResult = "Информация о клавиатуре:" & vbCrLf & vbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_Keyboard
Set colKeyboards = objClass.Instances_

' Перебираем элементы коллекции 
For Each objKeyboard In colKeyboards
  strResult = strResult & "Caption: " & _
              objKeyboard.Caption & VbCrLf
  strResult = strResult & "Description: " & _
              objKeyboard.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objKeyboard.DeviceID & VbCrLf
  strResult = strResult & "Layout: " & _
              objKeyboard.Layout & VbCrLf
  strResult = strResult & "Name: " & _
              objKeyboard.Name & VbCrLf
  strResult = strResult & "Number of Function Keys: " & _
              objKeyboard.NumberOfFunctionKeys & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objKeyboard.PNPDeviceID 
Next

' Выводим результат на экран
Wscript.Echo strResult
'************************* Конец ***********************************
