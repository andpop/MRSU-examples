/*******************************************************************/
/* ���: ExecWinApp.js                                              */
/* ����: JScript                                                   */
/* ��������: ������ � �������� ���������� (������ WshScriptExec)   */
/*******************************************************************/
var WshShell,theNotepad,Res,Text,Title;  //��������� ����������
//�������������� ��������� ��� ���������� ����
var vbYesNo=4,vbQuestion=32,vbYes=6,vbNo=7;

//������� ������ WshShell
WshShell = WScript.CreateObject("WScript.Shell");
WScript.Echo("��������� �������");
//��������� ���������� (������� ������ WshScriptExec)
theNotepad = WshShell.Exec("notepad");
WScript.Sleep(1000);  //���������������� ���������� ��������
Text="������� ������� (Status="+theNotepad.Status+")\n������� �������?";
Title="";
//������� ���������� ���� �� �����
Res=WshShell.Popup(Text,0,Title,vbQuestion+vbYesNo);
//����������, ����� ������ ������ � ���������� ����
if (Res==vbYes) {
  theNotepad.Terminate();  //��������� ������ ��������
  //���������������� ���������� �������� ��� ����, ����� �������
  //����� ���������
  WScript.Sleep(100);
  WScript.Echo("������� ������ (Status="+theNotepad.Status+")");
  }
/*************  ����� *********************************************/
