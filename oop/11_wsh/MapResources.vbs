'********************************************************************
' ���: MapResources.vbs
' ����: VBScript
' ��������: ���������� � ����������� ������� ������ � ���������
'********************************************************************
Option Explicit

' ��������� ����������
Dim WshNetwork,Drive,NetPath,Port,NetPrinter

Drive="K:"   ' ����� �����
NetPath="\\RS_NT_Server\d"    ' ������� ���� ��� ����������� �����
Port="LPT1"   ' �������� ���������� �����
' ������� ���� ��� ����������� ��������
NetPrinter="\\104_Stepankova\HP"

' ������� ������ WshNetwork
Set WshNetwork = WScript.CreateObject("WScript.Network")
' ������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

On Error Resume Next  ' �������� ��������� ������ ������� ����������
'*************  ���������� �������� �����  ***********************
' ��������� ������� ����
WshNetwork.RemoveNetworkDrive Drive
If Err.Number<>0 Then
  Mess="������ ��� ���������� ����� " & Drive & vbCrLf & _
       "��� ������: " &  e.number & vbCrLf &+ _
       "��������: " & e.description
  WshShell.Popup Mess,0,"���������� �������� �����",vbCritical
Else
  ' ��� � �������
  Mess="���� " & Drive & " �������� �������"
  WshShell.Popup Mess,0,"���������� �������� �����",vbInformation
End If

'*************  ����������� �������� �����  ***********************
' ���������� ������� ����
WshNetwork.MapNetworkDrive Drive,NetPath
If Err.Number<>0 Then
  Mess="������ ��� ����������� ����� " & Drive & " � " & NetPath &_
       "��� ������: " & e.number & "��������: " & e.description
  WshShell.Popup Mess,0,"����������� �������� �����",vbCritical
Else
  ' ��� � �������
  Mess="���� " & Drive & " ������� ��������� � " & NetPath
  WshShell.Popup Mess,0,"����������� �������� �����",vbInformation
End If

'*************  ������������ ���������� �����  ***********************
' ��������� ����� � ������� ���������
WshNetwork.RemovePrinterConnection Port
If Err.Number<>0 Then
  Mess="������ ��� ���������� ����� " & Port & "��� ������: " &_
        e.number & "��������: " & e.description
  WshShell.Popup Mess,0,"���������� ����� �� �������� �������",vbCritical
Else
  ' ��� � �������
  Mess="���� " & Port & " �������� �������"
  WshShell.Popup Mess,0,"���������� ����� �� �������� �������",_
                 vbInformation
End If

'*****  ����������� ���������� �����  � �������� ��������  *********
' ���������� ������� ������� � ���������� �����
WshNetwork.AddPrinterConnection Port,NetPrinter
If Err.Number<>0 Then
  Mess="������ ��� �������������� ����� " & Port & " �� " & NetPrinter &_
       "��� ������: " & e.number & "��������: " & e.description
  WshShell.Popup Mess,0,"����������� ����� � �������� �������",vbCritical
Else
  ' ��� � �������
  Mess="���� " & Port & " ������� ��������� � " & NetPrinter
  WshShell.Popup Mess,0,"����������� ����� � �������� �������",
                 vbInformation
End If
'*************  ����� *********************************************
