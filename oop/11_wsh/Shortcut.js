/*****************************************************************/
/* ���: Shortcut.js                                              */
/* ����: JScript                                                 */
/* ��������: �������� ������� � ����������� ������               */
/*****************************************************************/
//��������� ����������
var WshShell,MyShortcut,PathTarg,PathIcon,Res,PathShortcut;
//�������������� ��������� ��� ���������� ����
var vbYesNo=4,vbQuestion=32,vbYes=6;

//������� ������ WshShell
WshShell = WScript.CreateObject("WScript.Shell");
//������� ������ ��� ������ �����, � ������� ����� ������ �����
Res=WshShell.Popup("��� ������� �����?\n��  - �� ������� �����\n��� - � ���� ���������",0,
  "������ � ��������",vbQuestion+vbYesNo);
if (Res==vbYes) //������ ������ ��
  //���������� ���� � �������� �����
  PathShortcut = WshShell.SpecialFolders("Desktop");
else
  //���������� ���� � ���� ���������
  PathShortcut = WshShell.SpecialFolders("Programs");
//������� ������-�����
MyShortcut = WshShell.CreateShortcut(PathShortcut+"\\��� �����.lnk");
//������������� ���� � �����
PathTarg=WshShell.ExpandEnvironmentStrings("%windir%\\notepad.exe");
MyShortcut.TargetPath = PathTarg;
//��������� ���������� ������� ������
MyShortcut.Hotkey = "CTRL+ALT+N";
//�������� ������ �� ����� SHELL32.dll
PathIcon=
  WshShell.ExpandEnvironmentStrings("%windir%\\system32\\SHELL32.dll");
MyShortcut.IconLocation = PathIcon+", 1";
MyShortcut.WindowStyle=3;   //������������� ��� ���� (���������������)
MyShortcut.Save();  //��������� �����
WScript.Echo("����� ������|");
/*************  ����� *********************************************/
