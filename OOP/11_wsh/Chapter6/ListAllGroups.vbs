'********************************************************************
' ���: ListAllGroups.vbs
' ����: JScript
' ��������: ����� �� ����� ���� ���� ����� ��������� ���������� 
'********************************************************************
Option Explicit

'��������� ����������
Dim objComputer    ' ��������� ������� Computer
Dim objGroup       ' ��������� ������� Group
Dim strResult      ' ������ ��� ������ �� �����

'********************** ������ *************************************
' ����������� � ����������� Popov
Set objComputer = GetObject("WinNT://Popov")

strResult = "�� ���������� Popov ������� ������:" & vbCrLf  & vbCrLf

' ���������� �������� ��������� 
For Each objGroup In objComputer
  ' �������� ������� ������ Group
  If objGroup.Class = "Group" Then
    '��������� ������ � ������� �����
    strResult = strResult & objGroup.Name & vbCrLf
  End If
Next
    
'������� ���������� �� �����
WScript.Echo strResult
'*************  ����� *********************************************/
