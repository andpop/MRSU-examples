'*******************************************************************
' Имя: OSProperty.vbs
' Язык: VBScript
' Описание: Вывод свойств операционной системы
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer        ' Имя компьютера
Dim strNamespace       ' Имя пространства имен
Dim strClass           ' Имя класса 
Dim objClass           ' Объект SWbemObject (класс WMI)
Dim colOperatingSystems' Коллекция экземпляров класса WMI
Dim objOperatingSystem ' Элемент коллекции
Dim strResult          ' Строка для вывода на экран

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"
strResult = " Свойства операционной системы: " & VbCrLf & VbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_OperatingSystem
Set colOperatingSystems = objClass.Instances_

' Перебираем элементы коллекции 
For Each objOperatingSystem in colOperatingSystems
  ' Формирум строку для вывода на экран 
  strResult = strResult & "Boot Device: " & _ 
              objOperatingSystem.BootDevice & VbCrLf
  strResult = strResult & "Build Number: " & _
              objOperatingSystem.BuildNumber & VbCrLf 
  strResult = strResult & "Build Type: " & _
              objOperatingSystem.BuildType & VbCrLf
  strResult = strResult & "Caption: " & _
              objOperatingSystem.Caption & VbCrLf
  strResult = strResult & "Code Set: " & _
              objOperatingSystem.CodeSet & VbCrLf
  strResult = strResult & "Country Code: " & _
              objOperatingSystem.CountryCode & VbCrLf
  strResult = strResult & "Install Date: " & _
              objOperatingSystem.InstallDate & VbCrLf
  strResult = strResult & "Licensed Users: " & _
              objOperatingSystem.NumberOfLicensedUsers & VbCrLf
  strResult = strResult & "Organization: " & _
              objOperatingSystem.Organization & VbCrLf
  strResult = strResult & "OS Language: " & _
              objOperatingSystem.OSLanguage & VbCrLf
  strResult = strResult & "OS Product Suite: " & _
              objOperatingSystem.OSProductSuite & VbCrLf
  strResult = strResult & "OS Type: " & _
              objOperatingSystem.OSType & VbCrLf
  strResult = strResult & "Primary: " & _
              objOperatingSystem.Primary & VbCrLf
  strResult = strResult & "Registered User: " & _
              objOperatingSystem.RegisteredUser & VbCrLf
  strResult = strResult & "Serial Number: " & _
              objOperatingSystem.SerialNumber & VbCrLf
  strResult = strResult & "Version: " & _
              objOperatingSystem.Version & VbCrLf
Next

' Выводим результат на экран
Wscript.Echo strResult
'************************* Конец ***********************************
