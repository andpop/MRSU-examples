'*******************************************************************
' ���: ChangeRegistryValues.vbs
' ����: VBScript
' ��������: ��������� �������� ���������� �������
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strKeyPath        ' ��� ���������� �������
Dim strValueName      ' ��� ��������� �������
Dim strValue          ' �������� ���������� ��������� �������
Dim dwValue           ' �������� ��������� DWORD ������� 
Dim objReg            ' ������ SWbemObject ��� ������ � ��������
Dim WshShell          ' ������ WshShell
Dim Res

' ��������� ���������
const HKEY_LOCAL_MACHINE = &H80000002
'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."

' ������ ��� ����������
strKeyPath = "SOFTWARE\Example key"

'������� ������ WshShell
Set WshShell=WScript.CreateObject("WScript.Shell")

' �������� ��������� �� ����� StdRegProv
Set objReg = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default:StdRegProv")
' ������ ��� ���������� ���������
strValueName = "Example String Value"
' ������ ����� �������� ���������
strValue = "New string value"
'������ �� ��������� �������� ���������
Res=WshShell.Popup("�������� �������� ��������� " & strValueName &_
       "?",0,"������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  ' ��������� ����� SetStringValue
  objReg.SetStringValue HKEY_LOCAL_MACHINE, strKeyPath, _
      strValueName, strValue
  WshShell.Popup "�������� ��������� " & strValueName & _
     " ��������!",0,"������ � ��������",vbInformation+vbOkOnly
End If

' ������ ��� ��������� DWORD
strValueName = "Example DWORD Value"
' ������ ����� �������� ���������
dwValue = 300
'������ �� ��������� �������� ���������
Res=WshShell.Popup("�������� �������� ��������� " & strValueName &_
       "?",0,"������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  ' ��������� ����� SetDWORDValue
  objReg.SetDWORDValue HKEY_LOCAL_MACHINE, strKeyPath, _
    strValueName, dwValue
  WshShell.Popup "�������� ��������� " & strValueName & _
     " ��������!",0,"������ � ��������",vbInformation+vbOkOnly
End If
'************************* ����� ***********************************
