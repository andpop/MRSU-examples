'*******************************************************************
' Имя: SoftwareFeatures.vbs
' Язык: VBScript
' Описание: Вывод списка установленных программных продуктов 
'           со всеми компонентами 
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colFeatures       ' Коллекция экземпляров класса WMI
Dim objFeature        ' Элемент коллекции
Dim strResult         ' Результирующая строка
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

' Константа для задания режима открытия файла
Const ForWriting = 2

' Процедура для записи информации в файл 
Sub TextOut (Text, File)
  ' Объявляем переменные
  Dim  objFSO, FOut 
  ' Создаем объект FileSystemObject
  Set  objFSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' Открываем выходной файл для записи
  Set  FOut = objFSO.OpenTextFile (File,ForWriting,true)
  ' Записываем текстовую строку в файл
  FOut.WriteLine Text
  ' Закрываем выходной файл
  FOut.Close
End Sub

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_SoftwareFeature"
strResult = "Компоненты  установленных программных " &_
            " продуктов:" & VbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_OperatingSystem
Set colFeatures = objClass.Instances_

' Перебираем элементы коллекции 
For Each objFeature in colFeatures
 ' Формируем строку для вывода на экран
  strResult = strResult &_
    "Name: " & objFeature.Name & VbCrLf &_
    "Product Name: " & objFeature.ProductName & VbCrLf &_ 
    vbtab & "Accesses: " & objFeature.Accesses & VbCrLf &_
    vbtab & "Attributes: " & objFeature.Attributes & VbCrLf &_
    vbtab & "Caption: " & objFeature.Caption & VbCrLf &_
    vbtab & "Description: " & objFeature.Description & VbCrLf &_
    vbtab & "Identifying Number: " & objFeature.IdentifyingNumber _
    & VbCrLf &_
    vbtab & "Install Date: " & objFeature.InstallDate & VbCrLf &_
    vbtab & "Install State: " & objFeature.InstallState & VbCrLf &_
    vbtab & "Last Use: " & objFeature.LastUse & VbCrLf &_
    vbtab & "Name: " & objFeature.Name & VbCrLf &_
    vbtab & "Vendor: " & objFeature.Vendor & VbCrLf &_
    vbtab & "Version: " & objFeature.Version & VbCrLf & VbCrLf 
Next

' Выводим результат в файл с помощью функции TextOut
TextOut  strResult, "C:\SoftwareFeatures.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\SoftwareFeatures.txt" )
'************************* Конец ***********************************
