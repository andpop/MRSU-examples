'*******************************************************************
' ���: KillProcess.vbs
' ����: VBScript
' ��������: ���������� ����������� ��������
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemServices    
Dim colProcesses      ' ��������� ����������� ������ WMI
Dim objProcess        ' ������� ���������
Dim WshShell          ' ������ WshShell
Dim Res

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

' ��������� ��������� ��������� NOTEPAD.EXE
Set colProcesses = objService.ExecQuery(_
           "SELECT * FROM Win32_Process WHERE Name='NOTEPAD.EXE'")

'������ �� ���������� ������ ���� ���������
Res=WshShell.Popup("��������� ������ ���� ���������?",0,_
  "������ � ����������",vbQuestion+vbYesNo)
' ��������� ��������� ��������
If Res=vbYes Then
  '���������� ���������
  For Each objProcess in colProcesses
    ' ��������� ����������
    objProcess.Terminate()
  Next
End If
'************************* ����� ***********************************
