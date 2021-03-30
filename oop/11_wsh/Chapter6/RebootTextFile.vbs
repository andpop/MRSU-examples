'*******************************************************************
' Имя: RebootTextFile.vbs
' Язык: VBScript
' Описание: Перезагрузка всех компьютеров, указанных в текстовом файле
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colInstances      ' Коллекция экземпляров класса WMI
Dim objInstance       ' Элемент коллекции
Dim objDictionary     ' Объект Dictionary 
Dim objItem           ' Элемент объекта Dictionary
' Константа для задания режима открытия файла
Const ForReading = 1

' Процедура для заполнения объекта Dictionary
Sub FillComputerDictionary(File)
' Объявляем переменные
Dim objFSO, objTextFile,i,s
  ' Создаем объект Dictionary
  Set objDictionary = CreateObject("Scripting.Dictionary")
  ' Создаем объект FileSystemObject
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  ' Открываем файл для чтения
  Set objTextFile = objFSO.OpenTextFile(File, ForReading)
  i = 0
  ' Цикл для чтения строк из файла
  Do Until objTextFile.AtEndOfStream
    ' Читаем строку из файла
    s = objTextFile.Readline
    ' Добавляем элемент в объект Dictionary
    objDictionary.Add i, s
    i = i + 1
  Loop

End Sub

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"

' Заполняем объект Dictionary значениями из файла C:\ComputerList.txt
FillComputerDictionary("C:\ComputerList.txt")

' Перебираем в цикле все элементы объекта Dictionary
For Each objItem in objDictionary
  ' Получаем имя компьютера из текущего элемента объекта Dictionary
  strComputer = objDictionary.Item(objItem)
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
