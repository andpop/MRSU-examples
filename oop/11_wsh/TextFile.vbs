'*******************************************************************
' ���: TextFile.vbs                                                
' ����: VBScript                                                  
' ��������: ������ ����� � ��������� ���� � ������ �� ����     
'*******************************************************************
Dim FSO,F,TextStream,s  '��������� ����������
' �������������� ���������
Const ForReading = 1, ForWriting = 2, TristateUseDefault = -2

' ������� ������ FileSystemObject
Set FSO=WScript.CreateObject("Scripting.FileSystemObject")
' ������� � ������� �������� ���� test1.txt
FSO.CreateTextFile "test1.txt"
' ������� ������ File ��� ����� test1.txt
set F=FSO.GetFile("test1.txt")
' ������� ������ TextStream (���� ����������� ��� ������)
Set TextStream=F.OpenAsTextStream(ForWriting, TristateUseDefault)
' ���������� � ���� ������
TextStream.WriteLine "��� ������ ������"
' ��������� ����
TextStream.Close
' ��������� ���� ��� ������
Set TextStream=F.OpenAsTextStream(ForReading, TristateUseDefault)
' ��������� ������ �� �����
s=TextStream.ReadLine
' ��������� ���� 
TextStream.Close
' ���������� ������ �� ������
WScript.Echo "������ ������ �� ����� test1.txt:" & vbCrLf & vbCrLf & s
'*************  ����� *********************************************
