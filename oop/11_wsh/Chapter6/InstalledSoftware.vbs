'*******************************************************************
' Имя: InstalledSoftware.vbs
' Язык: VBScript
' Описание: Вывод списка установленных программных продуктов 
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colSoftware       ' Коллекция экземпляров класса WMI
Dim objSoftware       ' Элемент коллекции
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
strClass = "Win32_Product"
strResult = "Список установленных программных продуктов:  " & VbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_Product
Set colSoftware = objClass.Instances_

' Перебираем элементы коллекции 
For Each objSoftware in colSoftware
  ' Формируем строку для вывода на экран
  strResult = strResult &_
    " Name: " & objSoftware.Name & VbCrLf & _
    vbTab & "Caption: " & objSoftware.Caption & VbCrLf & _
    vbTab & "Description: " & objSoftware.Description & VbCrLf & _
    vbTab & "IdentifyingNumber: " & objSoftware.IdentifyingNumber & _
    VbCrLf & _
    vbTab & "InstallLocation: " & objSoftware.InstallLocation & VbCrLf _
    & vbTab & "InstallState: " & objSoftware.InstallState & VbCrLf & _    
    vbTab & "PackageCache: " & objSoftware.PackageCache & VbCrLf & _
    vbTab & "SKUNumber: " & objSoftware.SKUNumber & VbCrLf & _    
    vbTab & "Vendor: " & objSoftware.Vendor & VbCrLf & _
    vbTab & "Version: " & objSoftware.Version & VbCrLf & VbCrLf
Next

' Выводим результат в файл с помощью функции TextOut
TextOut  strResult, "C:\InstalledSoftware.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\InstalledSoftware.txt" )
'************************* Конец ***********************************
