'*******************************************************************
' Имя: StartupCommand.vbs
' Язык: VBScript
' Описание: Вывод списка команд, выполняемых при загрузке компьютера
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colStartupCommands' Коллекция экземпляров класса WMI
Dim objStartupCommand ' Элемент коллекции
Dim strResult         ' Строка для вывода на экран

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_StartupCommand"
strResult = "Комманды выполняемые при загрузке компьютера :" & VbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_StartupCommand
Set colStartupCommands = objClass.Instances_

' Перебираем элементы коллекции 
For Each objStartupCommand in colStartupCommands
  strResult = strResult & objStartupCommand.Command & VbCrLf  
Next

' Выводим результат на экран
Wscript.Echo strResult
'************************* Конец ***********************************
