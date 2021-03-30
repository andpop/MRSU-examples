'*******************************************************************
' ���: ListFiles.vbs                                               
' ����: VBScript                                                   
' ��������: ��������� ������ ���� ������ ��������� ��������       
'*******************************************************************
'��������� ����������
Dim FSO,F,File,Files,WshShell,PathList,s

'������� ������ FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'������� ������ WshShell
Set WshShell = WScript.CreateObject("Wscript.Shell")
'������� ������ WshSpecialFolders
Set WshFldrs = WshShell.SpecialFolders
'���������� ���� � ����� "��� ���������"
PathList = WshFldrs.item("MyDocuments") & "\"
'������� ������ Folder ��� ����� "��� ���������"
Set F = FSO.GetFolder(PathList)
'������� ��������� ������ �������� "��� ���������"
Set Files = F.Files
s = "����� �� �������� " & PathList & VbCrLf
'���� �� ���� ������
For Each File In Files
  '��������� ������ � ������ �����
  s = s & File.Name & VbCrLf
Next

'������� ���������� ������ �� �����
WScript.Echo s
'*************  ����� *********************************************
