'*******************************************************************
' ���: DriveInfo.vbs                                               
' ����: VBScript                                                   
' ��������: ����� �� ����� ������� ����� C:                       
'*******************************************************************
'��������� ����������
Dim FSO,D,TotalSize,FreeSpace,s
'������� ������ FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'������� ������ Drive ��� ����� C:
Set D = FSO.GetDrive("C:")
s = "���������� � ����� C:" & VbCrLf
'�������� �������� ����� �����
s = s &"�������� �����: " & D.SerialNumber & VbCrLf
'�������� ����� ���� �����
s = s & "����� ����: " & D.VolumeName & VbCrLf
'��������� ����� ����� ����� � ����������
TotalSize = D.TotalSize/1024
s = s & "�����: " & TotalSize & " Kb" & VbCrLf
'��������� ����� ���������� ������������ ����� � ����������
FreeSpace = D.FreeSpace/1024
s = s & "��������: " & FreeSpace & " Kb" & VbCrLf
'������� �������� ����� �� �����
WScript.Echo s
'*************  ����� *********************************************
