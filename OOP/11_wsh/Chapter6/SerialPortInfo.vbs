'*******************************************************************
' ���: SerialPortInfo.vbs
' ����: VBScript
' ��������: ����� ���������� � ���������������� ������ 
'*******************************************************************
Option Explicit
On Error Resume Next

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colPorts          ' ��������� ����������� ������ WMI
Dim objPort           ' ������� ���������
Dim strCapability     ' �������������� ������ �����
Dim strResult         ' �������������� ������
Dim WshShell          ' ������ WshShell
Dim theNotepad        ' ������ WshScriptExec

' ��������� ���������
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16
Const ForWriting = 2

' ��������� ��� ������ ���������� � ���� 
Sub TextOut (Text, File)
  ' ��������� ����������
  Dim  objFSO, FOut 
  ' ������� ������ FileSystemObject
  Set  objFSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' ��������� �������� ���� ��� ������
  Set  FOut = objFSO.OpenTextFile (File,ForWriting,true)
  ' ���������� ��������� ������ � ����
  FOut.WriteLine Text
  ' ��������� �������� ����
  FOut.Close
End Sub

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_SerialPort"
strResult = "���������� � ���������������� ������:" & vbCrLf & vbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_ParallelPort
Set colPorts = objClass.Instances_

' ���������� �������� ��������� 
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

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\Ports.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\Ports.txt" )
'************************* ����� ***********************************
