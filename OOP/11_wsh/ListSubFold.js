/*******************************************************************/
/* ���: ListSubFold.js                                             */
/* ����: JScript                                                   */
/* ��������: ��������� ������ ���� ������������ ��������� �������� */
/*******************************************************************/
//��������� ����������
var FSO,F,SFold,SubFolders,s;

//������� ������ FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//���� � ��������
SFold="C:\\Program Files";
s="������� "+SFold+"\n";
s+="�����������:\n";
//������� ������ Folder ��� �������� C:\Program Files
F=FSO.GetFolder(SFold);
//������� ��������� ������������ �������� C:\Program Files
SubFolders= new Enumerator(F.SubFolders);
//���� �� ���� ������������
for (; !SubFolders.atEnd(); SubFolders.moveNext()) {
  s+=SubFolders.item()+"\n";  //��������� ������ � ������ �����������
  }
//������� ���������� ������ �� �����
WScript.Echo(s);
/*************  ����� *********************************************/
