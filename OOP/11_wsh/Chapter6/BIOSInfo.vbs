'*******************************************************************
' Имя: BIOSInfo.vbs
' Язык: VBScript
' Описание: Вывод информации о BIOS
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colInstances      ' Коллекция экземпляров класса WMI
Dim objBIOS           ' Элемент коллекции
Dim strResult         ' Результирующая строка

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_BIOS"
strResult = "Информация о BIOS :" & VbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("winmgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_BIOS
Set colInstances = objClass.Instances_

' Перебираем элементы коллекции 
For Each objBIOS in colInstances
  strResult = strResult & "Name: " & objBIOS.Name & VbCrLf
  strResult = strResult & "Manufacturer: " & objBIOS.Manufacturer &_
     VbCrLf
  strResult = strResult & "Caption: " & objBIOS.Caption & VbCrLf
  strResult = strResult & "Description: " & objBIOS.Description & VbCrLf    
  strResult = strResult & "Build Number: " & objBIOS.BuildNumber & VbCrLf
  strResult = strResult & "Current Language: " & objBIOS.CurrentLanguage &_ 
  VbCrLf
  strResult = strResult & _
   "Installable Languages: " & objBIOS.InstallableLanguages & VbCrLf
  strResult = strResult & "Primary BIOS: " & objBIOS.PrimaryBIOS & VbCrLf
  strResult = strResult & "Release Date: " & objBIOS.ReleaseDate & VbCrLf
  strResult = strResult & "Serial Number: " & objBIOS.SerialNumber &_
    VbCrLf
  strResult = strResult & "SMBIOS Version: " & _
    objBIOS.SMBIOSBIOSVersion & VbCrLf
  strResult = strResult & _
    "SMBIOS Major Version: " & objBIOS.SMBIOSMajorVersion & VbCrLf
  strResult = strResult & _
    "SMBIOS Minor Version: " & objBIOS.SMBIOSMinorVersion & VbCrLf
  strResult = strResult & "SMBIOS Present: " & objBIOS.SMBIOSPresent _
    & VbCrLf
  strResult = strResult & "Status: " & objBIOS.Status & VbCrLf
  strResult = strResult & "Version: " & objBIOS.Version & VbCrLf
Next

'Выводим строку на экран
Wscript.Echo strResult
'************************* Конец ***********************************
