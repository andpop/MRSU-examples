'********************************************************************
' ���: NetworkParam.vbs
' ����: VBScript
' ��������: ����� ������� ���������� �������
'********************************************************************
Option Explicit

Dim WshNetwork,s,NetwDrives,i,NetwPrinters  ' ��������� ����������

' ������� ������ WshNetwork
Set WshNetwork = WScript.CreateObject("WScript.Network")

s="������� ��������� �������:" & vbCrLf & vbCrLf
' ������� �� ����� �������� ComputerName, UserName � UserDomain
s=s & "��� ������: " & WshNetwork.ComputerName & vbCrLf
s= s & "��� ������������: " & WshNetwork.UserName & vbCrLf
s= s & "�����: " & WshNetwork.UserDomain
WScript.Echo s
'*************  ����� *********************************************
