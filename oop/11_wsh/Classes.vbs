'*******************************************************************
' Имя: Classes.vbs
' Язык: VBScript
' Описание: Просмотр всех классов в пространстве имен
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer        ' Имя компьютера
Dim strResult          ' Результат (текстовое сообщение) 
Dim strNamespace       ' Имя пространства имен
Dim WshShell           ' Объект WshShell
Dim objService         ' Объект SWbemServices
Dim colClasses         ' Коллекция классов
Dim objClass           ' Элемент коллекции
Dim theNotepad         ' Объект WshScriptExec

' Константа для задания режима открытия файла
Const ForWriting = 2

' Функция для записи информации в файл 
Sub TextOut (Text, File)
  ' Объявляем переменные
  Dim  FSO, FOut 
  ' Создаем объект FileSystemObject
  Set  FSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' Открываем выходной файл для записи
  Set  FOut = FSO.OpenTextFile (File,ForWriting,true)
  ' Записываем текстовую строку в файл
  FOut.WriteLine Text
  ' Закрываем выходной файл
  FOut.Close
End Sub

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strResult = "" 
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен WMI
Set objService = GetObject("winmgmts:\\" & strComputer & "\" & strNamespace)

' Создаем коллекцию классов WMI
Set colClasses = objService.SubclassesOf()

' Перебираем элементы коллекции 
For Each objClass In colClasses
    'Формируем результирующую строку    
    strResult=strResult & "  " & objClass.Path_.Class & VbCrLf 
Next

' Выводим результат в файл с помощью функции TextOut
TextOut " Список классов в пространстве имен  " & strNamespace &_
        " : " & VbCrLf & strResult, "C:\Classes.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\Classes.txt" )
'************************* Конец ***********************************
