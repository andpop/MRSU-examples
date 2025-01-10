'*******************************************************************
' ���: ChangePropShare.vbs
' ����: VBScript
' ��������: ��������� ������� ����� ��� ����������� �������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim colShares         ' ��������� ����������� ������ WMI 
Dim objShare          ' ������� ���������
Dim iError            ' ��������, ������������ �������

' ��������� ���������
Const MAXIMUM_CONNECTIONS = 5
'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_
                                   strComputer & "\" & strNamespace)
' ������� ��������� ����������� ������ Win32_Share
Set colShares = objService.ExecQuery _
    ("SELECT * FROM Win32_Share WHERE Name = 'NewShare'")

' ���������� �������� ���������
For Each objShare In colShares
  ' �������� �������� ����� ������ �������
  iError = objShare.SetShareInfo(MAXIMUM_CONNECTIONS, _
        "��� ����� �������� ��� ����� ������ �������.")
  ' ��������� ������
  If iError <> 0 Then 
    ' ������� ��������� �� ������
    WScript.Echo "������ ��� ��� ��������� ������� " &_
                 " ����� ������ �������."
  Else
    ' ������� ��������� �� �������� ��������� ������� 
    WScript.Echo "�������� ����� ������ ������� ������� ��������."
  End If
Next
'************************* ����� ***********************************
