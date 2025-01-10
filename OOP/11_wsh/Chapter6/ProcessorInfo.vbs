'*******************************************************************
' Имя: ProcessorInfo.vbs
' Язык: VBScript
' Описание: Вывод свойств установленных процессоров
'*******************************************************************
Option Explicit
On Error Resume Next

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemServices    
Dim colProcessors     ' Коллекция экземпляров класса WMI
Dim objProcessor      ' Элемент коллекции
Dim strResult         ' Результирующая строка
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

' Объявляем константы
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16
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
strResult = "Информация о процессорах " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
' Создаем коллекцию экземпляров класса Win32_Processor
Set colProcessors = objService.ExecQuery(_
    "SELECT * FROM Win32_Processor",,_
     wbemFlagReturnImmediately+wbemFlagForwardOnly)
For Each objProcessor In colProcessors
  strResult = strResult & "Address Width: " & _
              objProcessor.AddressWidth & VbCrLf
  strResult = strResult & "Architecture: " & _
              objProcessor.Architecture & VbCrLf
  strResult = strResult & "Caption: " & _
              objProcessor.Caption & VbCrLf
  strResult = strResult & "Cpu Status: " & _
              objProcessor.CpuStatus & VbCrLf
  strResult = strResult & "Current Clock Speed: " & _
              objProcessor.CurrentClockSpeed & VbCrLf
  strResult = strResult & "Current Voltage: " & _
              objProcessor.CurrentVoltage & VbCrLf
  strResult = strResult & "Data Width: " & _
              objProcessor.DataWidth & VbCrLf
  strResult = strResult & "Description: " & _
              objProcessor.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objProcessor.DeviceID & VbCrLf
  strResult = strResult & "ExtClock: " & _
              objProcessor.ExtClock & VbCrLf
  strResult = strResult & "Family: " & _
              objProcessor.Family & VbCrLf
  strResult = strResult & "Install Date: " & _
              objProcessor.InstallDate & VbCrLf
  strResult = strResult & "L2 Cache Size: " & _
              objProcessor.L2CacheSize & VbCrLf
  strResult = strResult & "L2 Cache Speed: " & _
              objProcessor.L2CacheSpeed & VbCrLf
  strResult = strResult & "Level: " & _
              objProcessor.Level & VbCrLf
  strResult = strResult & "Manufacturer: " & _
              objProcessor.Manufacturer & VbCrLf
  strResult = strResult & "Maximum Clock Speed: " & _
              objProcessor.MaxClockSpeed & VbCrLf
  strResult = strResult & "Name: " & _
              objProcessor.Name & VbCrLf
  strResult = strResult & "Power Management Supported: " & _
              objProcessor.PowerManagementSupported & VbCrLf
  strResult = strResult & "Processor Id: " & _
              objProcessor.ProcessorId & VbCrLf
  strResult = strResult & "ProcessorType: " & _
              objProcessor.ProcessorType & VbCrLf
  strResult = strResult & "Revision: " & _
              objProcessor.Revision & VbCrLf
  strResult = strResult & "Socket Designation: " & _
              objProcessor.SocketDesignation & VbCrLf
  strResult = strResult & "Status: " & _
              objProcessor.Status & VbCrLf
  strResult = strResult & "StatusInfo: " & _
              objProcessor.StatusInfo & VbCrLf
  strResult = strResult & "Stepping: " & _
              objProcessor.Stepping & VbCrLf
  strResult = strResult & "Version: " & _
              objProcessor.Version & VbCrLf
  strResult = strResult & "********************************" & VbCrLf _
              & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\Processor.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\Processor.txt" )
'************************* Конец ***********************************
