'*******************************************************************
' ���: FolderInfo.vbs                                              
' ����: VBScript                                                   
' ��������: ����� �� ����� ���� �������� �������� ��������        
'*******************************************************************
Dim FSO,WshShell,FoldSize,s  '��������� ����������

'������� ������ FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

'���������� �������, �� �������� ��� ������� ��������
'(������� �������)
Set Folder = FSO.GetFolder(WshShell.CurrentDirectory)
'�������� ��� �������� ��������
s = "������� �������: " & Folder.Name & VbCrLf
'�������� ���� �������� �������� ��������
s = s & "���� ��������: " & Folder.DateCreated & VbCrLf
'��������� ������ �������� �������� � ����������
FoldSize=Folder.Size/1024
s = s & "�����: " & FoldSize & " Kb" & VbCrLf
'������� ���������� �� �����
WScript.Echo s
'*************  ����� *********************************************
