'*******************************************************************
' ���: CreateTempFile.vbs                                                
' ����: VBScript                                                   
' ��������: �������� ���������� ����� �� ��������� ������         
'*******************************************************************
Dim FSO,FileName,F,s  '��������� ����������
'������� ������ FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'���������� ��������� ��� �����
FileName = FSO.GetTempName
'������� ���� � ������ FileName
Set F = FSO.CreateTextFile(FileName, true) 
'��������� ����
F.Close
'�������� � �������� �����
WScript.Echo "��� ������ ���� " & FileName
'*************  ����� *********************************************
