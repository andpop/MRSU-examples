'*******************************************************************
' ���: DeleteFile.vbs
' ����: VBScript                                                   
' ��������: �������� � �������� �����                             
'*******************************************************************
'��������� ����������
Dim FSO,F,FileName

'������� ������ FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")
'������ ��� �����
FileName="C:\TestFile.txt"
'������� ����
Set F = FSO.CreateTextFile(FileName, true)
'���������� � ���� ������
F.WriteLine "�������� ����"
'��������� ����
F.Close
WScript.Echo "���� ������"
FSO.DeleteFile FileName
WScript.Echo "���� ������"
'*************  ����� *********************************************
