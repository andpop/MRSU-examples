'********************************************************************
' ���: UserInfo.vbs                                               
' ����: VBScript                                                    
' ��������: ����� ���������� � ������������ ���������� � �����     
'           ��� ������                                             
'********************************************************************
Option Explicit

'��������� ����������
Dim objUser      ' ��������� ������� User
Dim WshShell     ' ������ WshShell
Dim Res          ' ��������� ������� ������ � ���������� ����
Dim strPassword  ' ������ � ����� �������
Dim strResult    ' ������ ��� ������ �� �����

'********************** ������ *************************************
' ����������� � ������������� XUser ���������� Popov
Set objUser = GetObject("WinNT://Popov/XUser,user")
' ��������� ������ � ����������� � ������������
strResult = "���������� � ������������ XUser" & vbCrLf &_
        "���: " & objUser.Name & vbCrLf & _
        "��������: " & objUser.Description & vbCrLf
' ������� �������������� ������ �� �����
WScript.Echo strResult

' ������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
' ������ �� ��������� ������
Res = WshShell.Popup("�������� ������ � XUser?",0,_
  "����������������� �������������",vbQuestion+vbYesNo)
If Res=vbYes Then ' ������ ������ ��
  ' ������������� ����� ������
  objUser.SetPassword "NewPassword"
  ' ��������� ��������� ���������
  objUser.SetInfo
  WScript.Echo "������ ��� �������"
Else
  WScript.Echo "�� ���������� �� ��������� ������"
End If  
'*************  ����� *********************************************/
