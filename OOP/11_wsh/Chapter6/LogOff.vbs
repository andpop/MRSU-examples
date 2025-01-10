'*******************************************************************
' Имя: LogOff.vbs
' Язык: VBScript
' Описание: Завершение сеанса пользователя  
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colInstances      ' Коллекция экземпляров класса WMI
Dim objInstance       ' Элемент коллекции

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"

' Получаем указатель на класс WMI
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_OperatingSystem
Set colInstances = objClass.Instances_

' Перебираем элементы коллекции 
For Each objInstance In colInstances
  ' Выводим на экран предупреждение
  WScript.Echo "На компьютере " &  objInstance.CSNAME & VbCrLf &_
               "сеанс текущего пользователя будет завершен "  
  ' Для каждого экземпляра вызываем метод Win32Shutdown
  objInstance.Win32Shutdown(0)      
Next
'************************* Конец ***********************************
