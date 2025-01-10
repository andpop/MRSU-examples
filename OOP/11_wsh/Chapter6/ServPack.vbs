'*******************************************************************
' Имя: ServPack.vbs
' Язык: VBScript
' Описание: Вывод номера ServicePack для операционной системы
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer         ' Имя компьютера
Dim strNamespace        ' Имя пространства имен
Dim strClass            ' Имя класса 
Dim objClass            ' Объект SWbemObject (класс WMI)
Dim colOperatingSystems ' Коллекция экземпляров класса WMI
Dim objOperatingSystem  ' Элемент коллекции
Dim strResult           ' Строка для вывода на экран

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"
strResult = "ServicePack установленный на этом компьютере " & VbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_OperatingSystem
Set colOperatingSystems = objClass.Instances_

' Перебираем элементы коллекции 
For Each objOperatingSystem in colOperatingSystems
  ' Формируем строку для вывода на экран
  strResult = strResult & "№ " & _ 
              objOperatingSystem.ServicePackMajorVersion & "." &_
              objOperatingSystem.ServicePackMinorVersion & VbCrLf  
Next

' Выводим результирущую строку на экран
Wscript.Echo strResult
'************************* Конец ***********************************
