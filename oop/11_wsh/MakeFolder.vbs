'*******************************************************************
' ���: MakeFolder.vbs                                           
' ����: VBScript                                                   
' ��������: �������� ������ ��������                              
'*******************************************************************
'��������� ����������
Dim FSO, F, SubFolders

'������� ������ FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'������� ������� C:\Program Files\����� �����
FSO.CreateFolder("C:\Program Files\����� �����")
'������� ������ Folder ��� �������� C:\Program Files
Set F = FSO.GetFolder("C:\Program Files")
'������� ��������� ������������ �������� C:\Program Files
Set SubFolders = F.SubFolders
'������� ������� C:\Program Files\��� ���� ����� �����
SubFolders.Add "��� ���� ����� �����"
'*************  ����� *********************************************
