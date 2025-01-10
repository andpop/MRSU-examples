'********************************************************************
' ���: Registry.vbs
' ����: VBScript
' ��������: ������ � ��������� ��������
'********************************************************************
Option Explicit

'��������� ����������
Dim WshShell,Root,Key,Res,SValue,ValueName,SRegValue

Root="HKEY_CURRENT_USER"   '�������� ����
Key="\ExampleKey\"         '����� ����
ValueName="ExampleValue"   '��� ������ ���������
SValue="Value from WSH"    '�������� ������ ���������

'������� ������ WshShell
Set WshShell=WScript.CreateObject("WScript.Shell")

'������ �� �������� ������ �����
Res=WshShell.Popup("������� ����" & vbCrLf & Root & Key & "?",0,_
  "������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  '���������� ����� ����
  WshShell.RegWrite Root & Key, ""
  WshShell.Popup "����" & vbCrLf & Root & Key & " ������!",0,_
    "������ � ��������",vbInformation+vbOkOnly
End If

'������ �� ������ ������ ���������
Res=WshShell.Popup("�������� ��������" & vbCrLf & Root & Key & _
  ValueName & "?",0,"������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  '���������� ����� ��������� ��������
  WshShell.RegWrite Root & Key & ValueName,SValue,"REG_SZ"
  WshShell.Popup "��������" & vbCrLf & Root & Key & _
    ValueName & " �������!",0,"������ � ��������",vbInformation+vbOkOnly
  '��������� �������� ���������� ���������
  SRegValue=WshShell.RegRead(Root & Key & ValueName)
  '������� �� ����� ���������� ��������
  WshShell.Popup Root & Key & ValueName & "=" & SRegValue,0,_
    "������ � ��������",vbInformation+vbOkOnly
End If

'������ �� �������� ���������
Res=WshShell.Popup("������� ��������" & vbCrLf & Root & Key & _
  ValueName & "?",0,"������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  '������� ��������
  WshShell.RegDelete Root & Key & ValueName
  WshShell.Popup "��������" & vbCrLf & Root & Key & _
    ValueName & " ������!",0,"������ � ��������",vbInformation+vbOkOnly
End If

'������ �� �������� �������
Res=WshShell.Popup("������� ������" & vbCrLf & Root & Key & _
  "?",0,"������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then   '������ ������ ��
  '������� ������
  WshShell.RegDelete Root & Key
  WshShell.Popup "������" & vbCrLf & Root & Key & " ������!",0,_
    "������ � ��������",vbInformation+vbOkOnly
End If
'*************  ����� *********************************************
