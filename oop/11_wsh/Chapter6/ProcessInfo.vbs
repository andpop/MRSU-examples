'*******************************************************************
' Имя: ProcessInfo.vbs
' Язык: VBScript
' Описание: Вывод свойств запущенных процессов 
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemServices    
Dim colProcesses      ' Коллекция экземпляров класса WMI
Dim objProcess        ' Элемент коллекции
Dim strResult         ' Результирующая строка
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

' Объявляем константы
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16
Const ForWriting = 2

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
strResult = "Сведения о запущенных процессах " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)

Set colProcesses = objService.ExecQuery("SELECT * FROM Win32_Process",,_
                     wbemFlagReturnImmediately+wbemFlagForwardOnly)
For Each objProcess In colProcesses
  strResult = strResult & "Name: " & objProcess.Name & VbCrLf &_
  "Description: " & objProcess.Description & VbCrLf &_
  "Handle: " & objProcess.Handle & VbCrLf &_
  "Parent Process Id: " & objProcess.ParentProcessId & VbCrLf &_
  "Command Line: " & objProcess.CommandLine & VbCrLf &_
  "Creation Date: " & objProcess.CreationDate & VbCrLf &_
  "Executable Path: " & objProcess.ExecutablePath & VbCrLf &_
  "Priority: " & objProcess.Priority & VbCrLf &_
  "Maximum WorkingSet Size: " & objProcess.MaximumWorkingSetSize & VbCrLf &_
  "Minimum WorkingSet Size: " & objProcess.MinimumWorkingSetSize & VbCrLf &_
  "Page File Usage: " & objProcess.PageFileUsage & VbCrLf &_
  "Peak Virtual Size: " & objProcess.PeakVirtualSize & VbCrLf &_
  "Peak WorkingSet Size: " & objProcess.PeakWorkingSetSize & VbCrLf &_
  "********************************" & VbCrLf & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\Process.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\Process.txt" )
'************************* Конец ***********************************
