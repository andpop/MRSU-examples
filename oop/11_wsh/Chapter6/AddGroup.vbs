'********************************************************************
' ���: AddGroup.vbs                                                  
' ����: VBScript                                                    
' ��������: �������� ����� ������ �� ����������
'********************************************************************
Option Explicit

'��������� ����������
Dim objComputer        ' ��������� ������� Computer
Dim objGroup           ' ��������� ������� Group
Dim strGroup           ' ��� ����������� ������

' ������ ��� ������������
strGroup = "XGroup"
' ����������� � ����������� Popov
Set objComputer = GetObject("WinNT://Popov")
' ������� ������ ������ Group
Set objGroup = objComputer.Create("group",strGroup)
' ��������� ���������� �� ����������
objGroup.SetInfo
'*************  ����� *********************************************
