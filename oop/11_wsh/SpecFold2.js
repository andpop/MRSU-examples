/******************************************************************/
/* ���: SpecFold2.js                                              */
/* ����: JScript                                                  */
/* ��������: ����� �������� �������� ����������� ����� Windows    */
/******************************************************************/
var WshShell, WshFldrs, s;   //��������� ����������
//������� ������ WshShell
WshShell = WScript.CreateObject("Wscript.Shell");
//������� ������ WshSpecialFolders
WshFldrs = WshShell.SpecialFolders;
//��������� ������ � ������ � ���������� ����������� ������
s="��������� ����������� �����:\n\n";
s+="Desktop:\t"+WshFldrs("Desktop")+"\n";
s+="Favorites:\t"+WshFldrs("Favorites")+"\n";
s+="Programs:\t"+WshFldrs("Programs");
WScript.Echo(s);  //������� �������������� ������ �� �����
/*************  ����� *********************************************/
