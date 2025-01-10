'*******************************************************************
' Имя: InfoAllTempFolders.vbs
' Язык: VBScript
' Описание: Вывод свойств всех папок Temp на диске С:
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim strResult         ' Результат запроса
Dim colFolders        ' Коллекция экземпляров класса WMI
Dim objFolder         ' Элемент коллекции
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

' Объявляем константы
Const ForWriting = 2
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16

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

' Функция для конвертации даты формата WMI в строку
Function WMIDateStr(WMIDate)
    WMIDateStr = CDate(Mid(WMIDate, 5, 2) & "." & _
         Mid(WMIDate, 7, 2)  & "." &_
         Left(WMIDate, 4)    & " " &_
         Mid(WMIDate, 9, 2)  & ":" & _
         Mid(WMIDate, 11, 2) & ":" & _
         Mid(WMIDate, 13, 2))
End Function

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strResult = "Свойства всех папок Windows на диске С : " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' Создаем коллекцию экземпляров класса Win32_Directory
Set colFolders = objService.ExecQuery(_
  "SELECT * FROM Win32_Directory WHERE Drive = 'C:' AND " &_ 
  "FileName = 'Temp' ",,_
  wbemFlagReturnImmediately + wbemFlagReturnImmediately)

' Перебираем элементы коллекции
For Each objFolder in colFolders
    ' Формируем строку для вывода файл
  strResult = strResult &_
  "    Name: " & objFolder.Name & VbCrLf &_
  VbTab & "AccessMask: " & objFolder.AccessMask & VbCrLf &_
  VbTab & "Archive: " & objFolder.Archive & VbCrLf &_
  VbTab & "Caption: " & objFolder.Caption & VbCrLf &_
  VbTab & "Compressed: " & objFolder.Compressed & VbCrLf &_
  VbTab & "CompressionMethod: " & objFolder.CompressionMethod & VbCrLf &_
  VbTab & "CreationClassName: " & objFolder.CreationClassName & VbCrLf &_
  VbTab & "CreationDate: " & WMIDateStr(objFolder.CreationDate) & _
    VbCrLf &_
  VbTab & "CSCreationClassName: " & objFolder.CSCreationClassName & _
    VbCrLf &_
  VbTab & "CSName: " & objFolder.CSName & VbCrLf &_
  VbTab & "Description: " & objFolder.Description & VbCrLf &_
  VbTab & "Drive: " & objFolder.Drive & VbCrLf &_
  VbTab & "EightDotThreeFileName: " & objFolder.EightDotThreeFileName & _
    VbCrLf &_
  VbTab & "Encrypted: " & objFolder.Encrypted & VbCrLf &_
  VbTab & "EncryptionMethod: " & objFolder.EncryptionMethod & VbCrLf &_
  VbTab & "Extension: " & objFolder.Extension & VbCrLf &_
  VbTab & "FileName: " & objFolder.FileName & VbCrLf &_
  VbTab & "FileSize: " & objFolder.FileSize & VbCrLf &_
  VbTab & "FileType: " & objFolder.FileType & VbCrLf &_
  VbTab & "FSCreationClassName: " & objFolder.FSCreationClassName &_
    VbCrLf &_
  VbTab & "FSName: " & objFolder.FSName & VbCrLf &_
  VbTab & "Hidden: " & objFolder.Hidden & VbCrLf &_
  VbTab & "InstallDate: " & WMIDateStr(objFolder.InstallDate) & VbCrLf &_
  VbTab & "InUseCount: " & objFolder.InUseCount & VbCrLf &_
  VbTab & "LastAccessed: " & WMIDateStr(objFolder.LastAccessed) & _
    VbCrLf &_
  VbTab & "LastModified: " & WMIDateStr(objFolder.LastModified) & _
    VbCrLf &_
  VbTab & "Path: " & objFolder.Path & VbCrLf &_
  VbTab & "Readable: " & objFolder.Readable & VbCrLf &_
  VbTab & "Status: " & objFolder.Status & VbCrLf &_
  VbTab & "System: " & objFolder.System & VbCrLf &_
  VbTab & "Writeable: " & objFolder.Writeable & VbCrLf & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\PropAllFolder.txt"

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\PropAllFolder.txt" )
'************************* Конец ***********************************
