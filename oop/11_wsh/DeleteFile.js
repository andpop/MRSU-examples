/*******************************************************************/
/* ���: DeleteFile.js                                              */
/* ����: JScript                                                   */
/* ��������: �������� � �������� �����                             */
/*******************************************************************/
//��������� ����������
var FSO,F,FileName;

//������� ������ FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//������ ��� �����
FileName="C:\\TestFile.txt";
//������� ����
F=FSO.CreateTextFile(FileName, true);
//���������� � ���� ������
F.WriteLine("�������� ����");
//��������� ����
F.Close();
WScript.Echo("���� ������");
FSO.DeleteFile(FileName);
WScript.Echo("���� ������");
/*************  ����� *********************************************/
