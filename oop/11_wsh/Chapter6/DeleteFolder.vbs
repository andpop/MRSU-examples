'*******************************************************************
' ���: DeleteFolder.vbs
' ����: VBScript
' ��������: �������� ����� C:\Test
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim iError            ' ��������, ������������ �������
Dim colFolders        ' ��������� ����������� ������ WMI
Dim objFolder         ' ������� ���������

' ��������� ���������
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' ������� ��������� ����������� ������ Win32_Directory
Set colFolders = objService.ExecQuery(_
     "SELECT * FROM Win32_Directory WHERE Name = 'c:\\Test'",,_
      wbemFlagReturnImmediately + wbemFlagReturnImmediately)

' ���������� �������� ���������
For Each objFolder In colFolders
    ' ������� �����
    iError = objFolder.Delete 
    ' ��������� ������
    If iError <> 0 Then
      WScript.Echo "������ ��� �������� �����"
    Else 
      WScript.Echo "�������� ����� ������ �������"
    End If
Next
'************************* ����� ***********************************
