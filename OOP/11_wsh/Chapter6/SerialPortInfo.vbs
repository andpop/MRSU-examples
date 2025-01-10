'*******************************************************************
' Имя: SerialPortInfo.vbs
' Язык: VBScript
' Описание: Вывод информации о последовательных портах 
'*******************************************************************
Option Explicit
On Error Resume Next

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colPorts          ' Коллекция экземпляров класса WMI
Dim objPort           ' Элемент коллекции
Dim strCapability     ' Поддерживаемые режимы порта
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
strClass = "Win32_SerialPort"
strResult = "Информация о последовательных портах:" & vbCrLf & vbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_ParallelPort
Set colPorts = objClass.Instances_

' Перебираем элементы коллекции 
For Each objPort In colPorts
  strResult = strResult & "Binary: " & _
              objPort.Binary & VbCrLf
  strResult = strResult & "Description: " & _
              objPort.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objPort.DeviceID & VbCrLf
  strResult = strResult & "Maximum Baud Rate: " & _
              objPort.MaxBaudRate & VbCrLf
  strResult = strResult & "Maximum Input Buffer Size: " & _
              objPort.MaximumInputBufferSize & VbCrLf
  strResult = strResult & "Maximum Input Buffer Size: " & _
              objPort.MaximumInputBufferSize & VbCrLf
  strResult = strResult & "Maximum Output Buffer Size: " & _
              objPort.MaximumOutputBufferSize & VbCrLf
  strResult = strResult & "Name: " & _
              objPort.Name & VbCrLf
  strResult = strResult & "OS Auto Discovered: " & _
              objPort.OSAutoDiscovered & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objPort.PNPDeviceID & VbCrLf
  strResult = strResult & "Provider Type: " & _
              objPort.ProviderType & VbCrLf
  strResult = strResult & "Settable Baud Rate: " & _
              objPort.SettableBaudRate & VbCrLf
  strResult = strResult & "Settable Data Bits: " & _
              objPort.SettableDataBits & VbCrLf
  strResult = strResult & "Settable Flow Control: " & _
              objPort.SettableFlowControl & VbCrLf
  strResult = strResult & "Settable Parity: " & _
              objPort.SettableParity & VbCrLf
  strResult = strResult & "Settable Parity Check: " & _
              objPort.SettableParityCheck & VbCrLf
  strResult = strResult & "Settable RLSD: " & _
              objPort.SettableRLSD & VbCrLf
  strResult = strResult & "Settable Stop Bits: " & _
              objPort.SettableStopBits & VbCrLf
  strResult = strResult & "Supports 16-Bit Mode: " & _
              objPort.Supports16BitMode & VbCrLf
  strResult = strResult & "Supports DTRDSR: " & _
              objPort.SupportsDTRDSR & VbCrLf
  strResult = strResult & "Supports Elapsed Timeouts: " & _
              objPort.SupportsElapsedTimeouts & VbCrLf
  strResult = strResult & "Supports Int Timeouts: " & _
              objPort.SupportsIntTimeouts & VbCrLf
  strResult = strResult & "Supports Parity Check: " & _
              objPort.SupportsParityCheck & VbCrLf
  strResult = strResult & "Supports RLSD: " & _
              objPort.SupportsRLSD & VbCrLf
  strResult = strResult & "Supports RTSCTS: " & _
              objPort.SupportsRTSCTS & VbCrLf
  strResult = strResult & "Supports Special Characters: " & _
              objPort.SupportsSpecialCharacters & VbCrLf
  strResult = strResult & "Supports XOn XOff: " & _
              objPort.SupportsXOnXOff & VbCrLf
  strResult = strResult & "Supports XOn XOff Setting: " & _
              objPort.SupportsXOnXOffSet & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\Ports.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\Ports.txt" )
'************************* Конец ***********************************
