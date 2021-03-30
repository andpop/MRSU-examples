'*******************************************************************
' Имя: RebootArguments.vbs
' Язык: VBScript
' Описание: Перезагрузка всех компьютеров, указанных в командной
'           строке
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
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"

' Перебираем в цикле все параметры командной строки
For Each strComputer In WScript.Arguments
  ' Получаем указатель на класс WMI
  Set objClass = GetObject("WinMgmts:{(Shutdown,RemoteShutdown)}\\" &_ 
                 strComputer & "\" & strNamespace & ":" & strClass)
  ' Создаем коллекцию экземпляров класса Win32_OperatingSystem
  Set colInstances = objClass.Instances_

  ' Перебираем элементы коллекции 
  For Each objInstance In colInstances
    ' Выводим на экран предупреждение
    WScript.Echo "Компьютер " &  objInstance.CSNAME &_
                 " будет перезагружен "  
    ' Для каждого экземпляра вызываем метод Reboot
    objInstance.Reboot()
  Next
  
Next  
'************************* Конец ***********************************
