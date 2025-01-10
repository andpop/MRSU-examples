'*******************************************************************
' ���: CheckAccessRights.vbs
' ����: VBScript
' ��������: �������� ���� ������� � ���������� �������
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strKeyPath        ' ��� ���������� �������
Dim objReg            ' ������ SWbemObject ��� ������ � ��������
Dim bHasAccessRight   ' ������� ������� ������������� ����� �������
Dim strResult         ' ������ ��� ������ �� �����

' ��������� ���������
const HKEY_LOCAL_MACHINE = &H80000002
const KEY_QUERY_VALUE = &H0001
const KEY_SET_VALUE = &H0002
const KEY_CREATE_SUB_KEY = &H0004
const DELETE = &H00010000

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."

' �������� ��������� �� ����� StdRegProv
Set objReg = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default:StdRegProv")
' ������ ��� ����������
strKeyPath = "SOFTWARE\Example key"
strResult = "����� ������� � ���������� " & strKeyPath & ":"  & VbCrLf & VbCrLf

' ��������� ����� CheckAccess
objReg.CheckAccess HKEY_LOCAL_MACHINE, strKeyPath, KEY_QUERY_VALUE, bHasAccessRight
' ��������� ������� ����� �������
If bHasAccessRight = True Then
  strResult = strResult & "����� �� ������ ��������: ����" & VbCrLf
Else
  strResult = strResult & "����� �� ������ ��������: ���" & VbCrLf
End If	

' ��������� ����� CheckAccess
objReg.CheckAccess HKEY_LOCAL_MACHINE, strKeyPath, KEY_CREATE_SUB_KEY, bHasAccessRight
' ��������� ������� ����� �������
If bHasAccessRight = True Then
  strResult = strResult & "����� �� �������� �����������: ����" & VbCrLf
Else
  strResult = strResult & "����� �� �������� �����������: ���" & VbCrLf 
End If

' ��������� ����� CheckAccess
objReg.CheckAccess HKEY_LOCAL_MACHINE, strKeyPath, DELETE, bHasAccessRight
' ��������� ������� ����� �������
If bHasAccessRight = True Then
  strResult = strResult & "����� �� �������� ����������: ����" & VbCrLf 
Else
  strResult = strResult & "����� �� �������� ����������: ���" & VbCrLf 
End If

' ������� �������������� ������ �� �����
WScript.Echo strResult
'************************* ����� ***********************************
