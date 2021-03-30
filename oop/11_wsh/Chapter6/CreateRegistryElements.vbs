'*******************************************************************
' ���: CreateRegistryElements.vbs
' ����: VBScript
' ��������: �������� � ������� ������ ���������� � ���������  
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
                         
'������ �� �������� ������ �����
Res=WshShell.Popup("������� ���� " & strKeyPath & "?",0,_
  "������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  ' ������� ��������� � ������� HKEY_LOCAL_MACHINE
  objReg.CreateKey HKEY_LOCAL_MACHINE,strKeyPath
  WshShell.Popup "���� " & strKeyPath & " ������!",0,_
    "������ � ��������",vbInformation+vbOkOnly
Else
  WScript.Quit(0)  
End If  

' ������ ��� ���������� ���������
strValueName = "Example String Value"
' ������ �������� ���������� ���������
strValue = "string value"
'������ �� ������ ������ ���������
Res=WshShell.Popup("�������� ��������" & strValueName & "?",0,_
      "������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  ' �������� ����� SetStringValue
  objReg.SetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,strValue
  WshShell.Popup "�������� " & strValueName & _
      " �������!",0,"������ � ��������",vbInformation+vbOkOnly
Else      
  WScript.Quit(0)  
End If  

' ������ ��� ��������� DWORD
strValueName = "Example DWORD Value"
' ������ �������� ��������� DWORD
dwValue = 100
'������ �� ������ ������ ���������
Res=WshShell.Popup("�������� �������� " & strValueName & "?",0,_
      "������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  ' �������� ����� SetDWORDValue
  objReg.SetDWORDValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,dwValue
  WshShell.Popup "�������� " & strValueName & _
     " �������!",0,"������ � ��������",vbInformation+vbOkOnly
Else      
  WScript.Quit(0)  
End If  
'************************* ����� ***********************************
