'*******************************************************************
' ���: ProcessInfo.vbs
' ����: VBScript
' ��������: ����� ������� ���������� ��������� 
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemServices    
Dim colProcesses      ' ��������� ����������� ������ WMI
Dim objProcess        ' ������� ���������
Dim strResult         ' �������������� ������
Dim WshShell          ' ������ WshShell
Dim theNotepad        ' ������ WshScriptExec

' ��������� ���������
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16
Const ForWriting = 2

' ������� ��� ������ ���������� � ���� 
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
strResult = "�������� � ���������� ��������� " & VbCrLf & VbCrLf

' ������������ � ������������ ���� WMI
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

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\Process.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\Process.txt" )
'************************* ����� ***********************************
