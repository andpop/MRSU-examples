'*******************************************************************
' ���: CopyFile.vbs                                                
' ����: VBScript                                                   
' ��������: �������� � ����������� �����                          
'*******************************************************************
'��������� ����������
Dim FSO,F,WshShell,WshFldrs,PathCopy

'������� ������ FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'������� ����
Set F = FSO.CreateTextFile("C:\TestFile.txt", true)
'���������� � ���� ������
F.WriteLine "�������� ����"
'��������� ����
F.Close

'������� ������ WshShell
Set WshShell = WScript.CreateObject("Wscript.Shell")
'������� ������ WshSpecialFolders
Set WshFldrs = WshShell.SpecialFolders
'���������� ���� � �������� �����
PathCopy = WshFldrs.item("Desktop")+"\"
'������� ������ File ��� ����� C:\TestFile.txt
Set F = FSO.GetFile("C:\TestFile.txt")
'�������� ���� �� ������� ����
F.Copy PathCopy
'*************  ����� *********************************************
