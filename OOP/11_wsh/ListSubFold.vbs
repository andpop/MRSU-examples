'*******************************************************************
' ���: ListSubFold.vbs                                             
' ����: VBScript                                                   
' ��������: ��������� ������ ���� ������������ ��������� �������� 
'*******************************************************************
'��������� ����������
Dim FSO,F,SFold,SubFolders,Folder,s

'������� ������ FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'���� � ��������
SFold = "C:\Program Files"
s = "������� " & SFold & VbCrLf
s = s & "�����������:" & VbCrLf
'������� ������ Folder ��� �������� C:\Program Files
Set F=FSO.GetFolder(SFold)

'������� ��������� ������������ �������� C:\Program Files
Set SubFolders = F.SubFolders

'���� �� ���� ������������
For Each Folder In SubFolders
  '��������� ������ � ������ �����������
   s = s & Folder & VbCrLf
Next

'������� ���������� ������ �� �����
WScript.Echo s
'*************  ����� *********************************************/
