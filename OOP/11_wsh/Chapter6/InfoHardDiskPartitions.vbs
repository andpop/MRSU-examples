'*******************************************************************
' Имя: InfoHardDiskPartitions.vbs
' Язык: VBScript
' Описание: Получение информации о разделах жесткого диска
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim strResult         ' Результат запроса
Dim colDiskPartitions ' Коллекция экземпляров класса WMI
Dim objPartition      ' Элемент коллекции
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
strResult = "Разделы жесткого диска: " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' Создаем коллекцию экземпляров класса Win32_DiskPartition
Set colDiskPartitions = objService.ExecQuery _
                       ("Select * from Win32_DiskPartition")

' Перебираем элементы коллекции
For each objPartition in colDiskPartitions
  ' Формируем строку для вывода файл
  strResult = strResult &_
  vbTab & "Block Size: " & objPartition.BlockSize & VbCrLf &_
  vbTab & "Bootable: " & objPartition.Bootable & VbCrLf &_
  vbTab & "Boot Partition: " & objPartition.BootPartition & VbCrLf &_
  vbTab & "Description: " & objPartition.Description & VbCrLf &_
  vbTab & "Device ID: " & objPartition.DeviceID & VbCrLf &_
  vbTab & "Disk Index: " & objPartition.DiskIndex & VbCrLf &_
  vbTab & "Index: "  & objPartition.Index & VbCrLf &_
  vbTab & "Name: " & objPartition.Name & VbCrLf &_
  vbTab & "Number Of Blocks: " &_
           objPartition.NumberOfBlocks & VbCrLf &_
  vbTab & "Primary Partition: " &_
           objPartition.PrimaryPartition & VbCrLf &_
  vbTab & "Size: " & objPartition.Size & VbCrLf &_
  vbTab & "Starting Offset: " &_
           objPartition.StartingOffset & VbCrLf &_
  vbTab & "Type: " & objPartition.Type & VbCrLf & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\Partitions.txt"

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\Partitions.txt" )
'************************* Конец ***********************************
