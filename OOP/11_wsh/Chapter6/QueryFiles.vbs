'*******************************************************************
' Имя: QueryFiles.vbs
' Язык: VBScript
' Описание: Вывод списка файлов на диске C: с расширением doc
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim strResult         ' Результат запроса
Dim colFiles          ' Коллекция экземпляров класса WMI
Dim objFile           ' Элемент коллекции
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

' Объявляем константы
Const ForWriting = 2
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16

' Функция для записи информации в файл
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
strResult = "Все файлы на диске С: с расширением doc: " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' Создаем коллекцию экземпляров класса CIM_DataFile
Set colFiles = objService.ExecQuery(_
  "SELECT * FROM CIM_DataFile WHERE Drive = 'C:' AND " &_
  "Extension = 'doc' AND Name LIKE '%win%'",,_
   wbemFlagReturnImmediately + wbemFlagReturnImmediately)

' Перебираем элементы коллекции
For Each objFile in colFiles
    ' Формируем строку для вывода файл
    strResult = strResult & objFile.Name & "   Size: " &_
                objFile.FileSize & " байт" & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\Files.txt"

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\Files.txt" )
'************************* Конец ***********************************
