'*******************************************************************
' ���: DeleteRegistryKeys.vbs
' ����: VBScript
' ��������: �������� �� ������� ����������  
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strKeyPath        ' ��� ���������� �������
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
'������ �� �������� ���������
Res=WshShell.Popup("������� �������� " & strKeyPath & _
   strValueName & "?",0,"������ � ��������", vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  ' ��������� ����� DeleteValue
  objReg.DeleteKey HKEY_LOCAL_MACHINE, strKeyPath
  WshShell.Popup "������" & strKeyPath & " ������!",0,_
    "������ � ��������",vbInformation+vbOkOnly
End If
'************************* ����� ***********************************
