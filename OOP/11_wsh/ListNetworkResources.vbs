'********************************************************************
' ���: ListNetworkResources.vbs
' ����: JScript
' ��������: ����� ������������ ������� �������� (����� � ��������)
'********************************************************************
Option Explicit

Dim WshNetwork,s,NetwDrives,i,NetwPrinters  ' ��������� ����������

' ������� ������ WshNetwork
Set WshNetwork = WScript.CreateObject("WScript.Network")

'********   ����� ������ ���� ������������ ������� ������   *********
s="������������ ������� �����:" & vbCrLf & vbCrLf
' ������� ��������� � ������� � ������������ ������
Set NetwDrives = WshNetwork.EnumNetworkDrives()
i=0
While i<=NetwDrives.Count()-2  ' ���������� �������� ���������
  ' � ������ �������� ��������� ���������� ����� �����,
  ' �� ������ - ������� ��� ������� � �. �.
  s=s & NetwDrives.Item(i) & "  " & NetwDrives.Item(i+1) & vbCrLf
  i=i+2
Wend
WScript.Echo s   ' ������� �������������� ������ �� �����

'********    ����� ������ ���� ������������ ������� ���������    *******
s="������������ ������� ��������:" & vbCrLf & vbCrLf
' ������� ��������� � ������� � ������������ ���������
Set NetwPrinters = WshNetwork.EnumPrinterConnections()
i=0
While i<=NetwPrinters.Count()-2   ' ���������� �������� ���������
  ' � ������ �������� ��������� ���������� �������� ��������� ������,
  ' �� ������ - ������� ��� �������� � �. �.
  s=s & NetwPrinters.Item(i) & "  " & NetwPrinters.Item(i+1) & vbCrLf
  i=i+2
Wend
WScript.Echo s  '������� �������������� ������ �� �����
'*************  ����� *********************************************
