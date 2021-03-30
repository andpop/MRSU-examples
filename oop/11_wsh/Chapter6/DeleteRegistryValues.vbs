'*******************************************************************
' ���: DeleteRegistryValues.vbs
' ����: VBScript
' ��������: �������� �� ������� ���������� ��������� � ��������� DWORD  
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strKeyPath        ' ��� ���������� �������
Dim strValueName      ' ��� ��������� �������
Dim objReg            ' ������ SWbemObject ��� ������ � ��������
Dim WshShell          ' ������ WshShell
Dim Res

' ��������� ���������
const HKEY_LOCAL_MACHINE = &H80000002
'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."

'������� ������ WshShell
Set WshShell=WScript.CreateObject("WScript.Shell")

' �������� ��������� �� ����� StdRegProv
Set objReg = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default:StdRegProv")
' ������ ��� ����������
strKeyPath = "SOFTWARE\Example key"

' ������ ��� ���������� ���������
strValueName = "Example String Value"
'������ �� �������� ���������
Res=WshShell.Popup("������� �������� " & strKeyPath & "\" & _
   strValueName & "?",0,"������ � ��������", vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  ' ��������� ����� DeleteValue
  objReg.DeleteValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName
  WshShell.Popup "�������� " & strValueName & " ������!",0,_
     "������ � ��������",vbInformation+vbOkOnly
End If

' ������ ��� ��������� DWORD
strValueName = "Example DWORD Value"
'������ �� �������� ���������
Res=WshShell.Popup("������� �������� " & strKeyPath & "\" & _
   strValueName & "?",0,"������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  ' ��������� ����� DeleteValue
  objReg.DeleteValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName
  WshShell.Popup "�������� " & strValueName & " ������!",0,_
     "������ � ��������",vbInformation+vbOkOnly
End If
'************************* ����� ***********************************
