/*******************************************************************/
/* ���: MakeFolder.js                                             */
/* ����: JScript                                                   */
/* ��������: �������� ������ ��������                              */
/*******************************************************************/
//��������� ����������
var FSO, F, SubFolders;

//������� ������ FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//������� ������� C:\Program Files\����� �����
FSO.CreateFolder("C:\\Program Files\\����� �����");
//������� ������ Folder ��� �������� C:\Program Files
F=FSO.GetFolder("C:\\Program Files");
//������� ��������� ������������ �������� C:\Program Files
SubFolders=F.SubFolders;
//������� ������� C:\Program Files\��� ���� ����� �����
SubFolders.Add("��� ���� ����� �����");
/*************  ����� *********************************************/
