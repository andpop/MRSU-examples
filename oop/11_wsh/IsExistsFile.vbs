'******************************************************************
' ���: IsExistsFile.vbs                                            
' ����: VBScript                                                   
' ��������: �������� ������������� �����                          
'*******************************************************************
Dim FSO,FileName '��������� ����������

'������� ������ FileSystemObject
Set FSO = WScript.CreateObject("Scripting.FileSystemObject")

FileName = "C:\boot.ini"
if  FSO.FileExists(FileName)  Then
  '������� ���������� �� �����
  WScript.Echo "���� " & FileName & " ����������"
else
  '������� ���������� �� �����
  WScript.Echo "���� " & FileName & " �� ����������" 
end if
'*************  ����� *********************************************
