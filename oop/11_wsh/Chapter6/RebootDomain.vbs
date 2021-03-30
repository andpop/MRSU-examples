'*******************************************************************
' Имя: RebootDomain.vbs
' Язык: VBScript
' Описание: Перезагрузка всех компьютеров из домена Windows NT
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strOurComputer    ' Имя компьютера, с которого запущен сценарий
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colInstances      ' Коллекция экземпляров класса WMI
Dim objInstance       ' Элемент коллекции
Dim objDictionary     ' Объект Dictionary 
Dim objItem           ' Элемент объекта Dictionary

' Процедура для заполнения объекта Dictionary
Sub FillComputerDictionary()
' Объявляем переменные
Dim strDomain, objDomain, objComputer, i
  ' Создаем объект Dictionary
  Set objDictionary = CreateObject("Scripting.Dictionary")
  'Задаем имя домена
  strDomain = "WinNT://SBRM"
  'Связываемся с объектом Domain
  Set objDomain = GetObject(strDomain)
  'Устанавливаем фильтр для выделения объектов-компьютеров
  objDomain.Filter = Array("computer")
  
  i = 0
  ' Цикл для чтения строк из файла
  For Each objComputer In objDomain
    ' Добавляем элемент в объект Dictionary
    objDictionary.Add i, objComputer.Name
    i = i + 1
  Next

End Sub

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"

' Получаем указатель на класс WMI для локального комьютера
Set objClass = GetObject("WinMgmts:{(Shutdown,RemoteShutdown)}\\.\" &_ 
               strNamespace & ":" & strClass)
' Опреднляем имя локального компьютера
strOurComputer = objClass.CSName

' Заполняем объект Dictionary значениями из файла C:\ComputerList.txt
FillComputerDictionary()

' Перебираем в цикле все элементы объекта Dictionary
For Each objItem In objDictionary
  ' Получаем имя компьютера из текущего элемента объекта Dictionary
  strComputer = objDictionary.Item(objItem)
  ' Получаем указатель на класс WMI
  Set objClass = GetObject("WinMgmts:{(Shutdown,RemoteShutdown)}\\" &_ 
                 strComputer & "\" & strNamespace & ":" & strClass)
  ' Проверяем, не совпадает ли strComputer с именем локального 
  ' компьютера 
  If strOurComputer <> strComputer Then
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
  '************************* Конец ***********************************
