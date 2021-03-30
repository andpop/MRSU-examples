'*******************************************************************
' ���: GetProcessOwner.vbs
' ����: VBScript
' ��������: ����������� ��������� �������� 
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemServices    
Dim colProcesses      ' ��������� ����������� ������ WMI
Dim objProcess        ' ������� ���������
Dim strUserName       ' ��� ������������
Dim strUserDomain     ' �����, � ������� ��������������� ������������
Dim intRes            ' ��������� ���������� ������
Dim strResult         ' �������������� ������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
' ������� ��������� ��������� � ������ strProcess
Set colProcesses = objService.ExecQuery _
    ("SELECT * FROM Win32_Process WHERE Name='NOTEPAD.EXE'")

' ���������� ��������� ���������    
For Each objProcess In colProcesses
  ' ���������� ��������� �������� objProcess
  intRes = objProcess.GetOwner(strUserName,strUserDomain)
  If intRes=0 Then
    ' ������� ���������� � ��������� ��������
    WScript.Echo "���������� �������� " & objProcess.Name &_
      " �������� " & strUserDomain & "\" & strUserName
  Else
    ' ������� ���������� �� ������
    WScript.Echo "������ ��� ����������� ���������� �������� " _
      & objProcess.Name
  End If   
Next
'************************* ����� ***********************************
