'*******************************************************************
' ���: ServicesInfo.vbs
' ����: VBScript
' ��������: ����� ���������� � ������� 
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objWMIService        ' ������ SWbemServices    
Dim colServices       ' ��������� ����������� ������ WMI
Dim objService        ' ������� ���������
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
strResult = "���������� � ������� " & VbCrLf & VbCrLf

' ������������ � ������������ ���� WMI
Set objWMIService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)

Set colServices = objWMIService.ExecQuery("SELECT * FROM Win32_Service"_
                  ,,wbemFlagReturnImmediately+wbemFlagForwardOnly)
For Each objService In colServices
  strResult = strResult & "Name: " & _
              objService.Name & VbCrLf
  strResult = strResult & "Display Name: " & _
              objService.DisplayName & VbCrLf
  strResult = strResult & "Caption: " & _
              objService.Caption & VbCrLf
  strResult = strResult & "Description: " & _
              objService.Description & VbCrLf
  strResult = strResult & "Path Name: " & _
              objService.PathName & VbCrLf
  strResult = strResult & "ServiceType: " & _
              objService.ServiceType & VbCrLf
  strResult = strResult & "Status: " & _
              objService.Status & VbCrLf
  strResult = strResult & "State: " & _
              objService.State & VbCrLf
  strResult = strResult & "Started: " & _
              objService.Started & VbCrLf
  strResult = strResult & "Start Mode: " & _
              objService.StartMode & VbCrLf
  strResult = strResult & "Start Name: " & _
              objService.StartName & VbCrLf
  strResult = strResult & "Accept pause: " & _
              objService.AcceptPause & VbCrLf
  strResult = strResult & "Accept stop: " & _
              objService.AcceptStop & VbCrLf
  strResult = strResult & "********************************" & VbCrLf &_
              VbCrLf
Next

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\Services.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\Services.txt" )
'************************* ����� ***********************************
