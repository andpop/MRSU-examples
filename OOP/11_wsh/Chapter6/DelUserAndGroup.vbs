'********************************************************************
' ���: DelUserAndGroup.vbs  
' ����: VBScript                                                    
' ��������: �������� ������������ � ������ ����������
'********************************************************************
Option Explicit
On Error Resume Next

'��������� ����������
Dim objComputer          ' ��������� ������� Computer
Dim strUser              ' ��� ���������� ������������
Dim strGroup             ' ��� ��������� ������
Dim WshShell             ' ������ WshShell
Dim strMess              ' 

'********************** ������ *************************************
' ��� ���������� ������������
strUser = "XUser"    
' ��� ��������� ������
strGroup = "XGroup"  

' ����������� � ����������� Popov
Set objComputer = GetObject("WinNT://Popov")
' ������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

'*************  �������� ������������  ***********************
' ������� ������������
objComputer.Delete "user", strUser

' ������������ ������
If Err.Number <> 0 Then  
  strMess="������ ��� �������� ������������ " & strUser & vbCrLf & _
       "��� ������: " & Err.number & "��������: " & Err.description
  WshShell.Popup strMess,0,"�������� ������������",vbCritical

  ' ������� �������� ������� Err
  Err.Clear
Else
  ' ��� � �������
  strMess = "������������ " & strUser & " ������"
  WshShell.Popup strMess,0,"�������� ������������",vbInformation
End If

'*************  �������� ������  ***********************/
objComputer.Delete "group", strGroup

' ������������ ������
If Err.Number <> 0 Then  
  strMess="������ ��� �������� ������ " & strGroup & vbCrLf & _
       "��� ������: " & Err.number & "��������: " & Err.description
  ' ������� �������� ������� Err
  Err.Clear
Else
  ' ��� � �������
  strMess="������ " & strGroup & " �������"
  WshShell.Popup strMess,0,"�������� ������",vbInformation
End If
'*************  ����� *********************************************/
