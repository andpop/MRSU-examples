'*******************************************************************
' ���: ChangeServicePassword.vbs
' ����: VBScript
' ��������: ��������� ������ ������� ������, �� ����� ������� �������� 
'            ������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strService        ' ��� ������������ ����
Dim objWMIService     ' ������ SWbemServices    
Dim colServices       ' ��������� ����������� ������ WMI
Dim objService        ' ������� ���������
Dim intErr            ' ��� ��������
Dim strPassw          ' ������
Dim WshShell          ' ������ WshShell

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strService = "W3SVC"
strPassw = "DerParol"

' ������������ � ������������ ���� WMI
Set objWMIService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

' ��������� ��������� ����� � ������ W3SVC
Set colServices = objWMIService.ExecQuery _
    ("SELECT * FROM Win32_Service WHERE Name = '" & strService & "'")
    
' ���������� ���������    
For Each objService In colServices
    ' ��������� ����� Change ��� ������
    intErr = objService.Change( , , , , , , , strPassw)
    If intErr=0 Then
      ' ������� ��������� �� ������� ��������� ������
      WshShell.Popup "������ ��� ������� ������ " & strService & " �������!",0,_
        "��������� ������ ������",vbInformation+vbOkOnly
    Else
      ' ������� ��������� �� ������ ��� ��������� ������
      WshShell.Popup _
        "������ ��� ��������� ������ ��� ������� ������ " & strService _
        & "!",0,"��������� ������ ������",vbExclamation+vbOkOnly
    End If
Next
'************************* ����� ***********************************
