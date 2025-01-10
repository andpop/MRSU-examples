'*******************************************************************
' ���: StartProcess.vbs
' ����: VBScript
' ��������: ������ ������ ��������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������
Dim objClass          ' ����� WMI
Dim intError          ' ��������, ������������ �������
Dim intProcessID      ' ������������� ���������� ��������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "Shikin"
strNamespace = "Root\CIMV2"
strClass = "Win32_Process"

' ������� ������ �� ����� WMI 
Set objClass = GetObject("WinMgmts:" & _
     "{impersonationLevel=impersonate}!\\" &_
     strComputer & "\" & strNamespace & ":" & strClass)

' ��������� ����� Create
intError = objClass.Create("Notepad.exe", null, null, intProcessID)

' ��������� ������������ ������� ��������
If intError <> 0 Then
  ' ������� �� ����� ��������� �� ������
  WScript.Echo "��� �������� �������� NOTEPAD.EXE ��������� ������"
Else
  ' ������� �� ����� ��������� �� ������� �������
  WScript.Echo "������� NOTEPAD.EXE ������� �������. " 
End If
'************************* ����� ***********************************
