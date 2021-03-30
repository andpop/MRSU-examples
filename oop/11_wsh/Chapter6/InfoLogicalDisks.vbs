'*******************************************************************
' Имя: InfoLogicalDisks.vbs
' Язык: VBScript
' Описание: Получение информации о логических дисках
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim strResult         ' Результат запроса
Dim colLogicalDisks   ' Коллекция экземпляров класса WMI
Dim objLogicalDisk    ' Элемент коллекции
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

' Объявляем константы
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
strResult = "Логические диски: " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' Создаем коллекцию экземпляров класса Win32_LogicalDisk
Set colLogicalDisks = objService.ExecQuery _
                    ("Select * from Win32_LogicalDisk")

' Перебираем элементы коллекции   
For Each objLogicalDisk In colLogicalDisks
  ' Формируем строку для вывода файл    
  strResult = strResult &_
  "    DeviceID: " &  objLogicalDisk.DeviceID & VbCrLf &_
  vbTab & "Compressed: " &  objLogicalDisk.Compressed & VbCrLf &_
  vbTab & "Description: " &  objLogicalDisk.Description & VbCrLf &_
  vbTab & "DriveType: " &  objLogicalDisk.DriveType & VbCrLf &_
  vbTab & "FileSystem: " &  objLogicalDisk.FileSystem & VbCrLf &_
  vbTab & "FreeSpace: " &  objLogicalDisk.FreeSpace & VbCrLf &_
  vbTab & "MediaType: " &  objLogicalDisk.MediaType & VbCrLf &_
  vbTab & "Name: " &  objLogicalDisk.Name & VbCrLf &_
  vbTab & "QuotasDisabled: " &  objLogicalDisk.QuotasDisabled & VbCrLf &_
  vbTab & "QuotasIncomplete: " &  objLogicalDisk.QuotasIncomplete _ 
    & VbCrLf &_
  vbTab & "QuotasRebuilding: " &  objLogicalDisk.QuotasRebuilding _
    & VbCrLf &_
  vbTab & "Size: " &  objLogicalDisk.Size & VbCrLf &_
  vbTab & "SupportsDiskQuotas: " & _
        objLogicalDisk.SupportsDiskQuotas & VbCrLf &_
  vbTab & "SupportsFileBasedCompression: " & _
        objLogicalDisk.SupportsFileBasedCompression & VbCrLf &_
  vbTab & "SystemName: " &  objLogicalDisk.SystemName & VbCrLf &_
  vbTab & "VolumeDirty: " &  objLogicalDisk.VolumeDirty & VbCrLf &_
  vbTab & "VolumeName: " &  objLogicalDisk.VolumeName & VbCrLf &_
  vbTab & "VolumeSerialNumber: " &  _
        objLogicalDisk.VolumeSerialNumber & VbCrLf & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\LogicalDisks.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\LogicalDisks.txt" )
'************************* Конец ***********************************
