/*******************************************************************/
/* ���: ListFiles.js                                               */
/* ����: JScript                                                   */
/* ��������: ��������� ������ ���� ������ ��������� ��������       */
/*******************************************************************/
//��������� ����������
var FSO,F,Files,WshShell,PathList,s;

//������� ������ FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");

//������� ������ WshShell
WshShell=WScript.CreateObject("Wscript.Shell");
//������� ������ WshSpecialFolders
WshFldrs=WshShell.SpecialFolders;
//���������� ���� � ����� "��� ���������"
PathList=WshFldrs.item("MyDocuments")+"\\";

//������� ������ Folder ��� ����� "��� ���������"
F=FSO.GetFolder(PathList);
//������� ��������� ������ �������� "��� ���������"
Files=new Enumerator(F.Files);
s = "����� �� �������� "+PathList+"\n";
//���� �� ���� ������
for (; !Files.atEnd(); Files.moveNext()) 
  //��������� ������ � ������ �����
  s+=Files.item().Name+"\n";
//������� ���������� ������ �� �����
WScript.Echo(s);
/*************  ����� *********************************************/
