/*******************************************************************/
/* ���: CopyFile.js                                                */
/* ����: JScript                                                   */
/* ��������: �������� � ����������� �����                          */
/*******************************************************************/
//��������� ����������
var FSO,F,WshShell,WshFldrs,PathCopy;

//������� ������ FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//������� ����
F=FSO.CreateTextFile("C:\\TestFile.txt", true);
//���������� � ���� ������
F.WriteLine("�������� ����");
//��������� ����
F.Close();

//������� ������ WshShell
WshShell=WScript.CreateObject("Wscript.Shell");
//������� ������ WshSpecialFolders
WshFldrs=WshShell.SpecialFolders;
//���������� ���� � �������� �����
PathCopy=WshFldrs.item("Desktop")+"\\";
//������� ������ File ��� ����� C:\TestFile.txt
F=FSO.GetFile("C:\\TestFile.txt");
//�������� ���� �� ������� ����
F.Copy(PathCopy);
/*************  ����� *********************************************/
