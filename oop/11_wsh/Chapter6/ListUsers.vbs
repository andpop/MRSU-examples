'********************************************************************
' ���: ListUsers.vbs                                                
' ����: VBScript                                    
' ��������: ����� �� ����� ���� ���� ������������� �������� ������
'********************************************************************
Option Explicit

'��������� ����������
Dim objGroup       ' ��������� ������� Group
Dim objUser        ' ��������� ������� User
Dim strResult      ' ������ ��� ������ �� �����

'********************** ������ *************************************
' ����������� � ������� ������������ ���������� Popov
Set objGroup = GetObject("WinNT://Popov/������������,group")

strResult = "��� ������������ ������ ������������ �� ���������� Popov:" & vbCrLf

' ���������� �������� ��������� 
For Each objUser In objGroup.Members()
  ' ��������� ������ � ������� �������������
  strResult = strResult & objUser.Name & vbCrLf
Next

' ����� ���������� �� �����
WScript.Echo strResult
'*************  ����� *********************************************