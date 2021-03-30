/********************************************************************/
/* ���: Registry.js                                                 */
/* ����: JScript                                                    */
/* ��������: ������ � ��������� ��������                            */
/********************************************************************/
//��������� ����������
var WshShell,Root,Key,Res,SValue,ValueName,SRegValue;
//�������������� ��������� ��� ���������� ����
var vbYesNo=4,vbQuestion=32,vbInformation=64,vbYes=6,vbOkOnly=0;

Root="HKEY_CURRENT_USER";  //�������� ����
Key="\\ExampleKey\\";      //����� ����
ValueName="ExampleValue";  //��� ������ ���������
SValue="Value from WSH";   //�������� ������ ���������

//������� ������ WshShell
WshShell=WScript.CreateObject("WScript.Shell");

//������ �� �������� ������ �����
Res=WshShell.Popup("������� ����\n"+Root+Key+"?",0,
  "������ � ��������",vbQuestion+vbYesNo);
if (Res==vbYes) { //������ ������ ��
  //���������� ����� ����
  WshShell.RegWrite(Root+Key,"");
  WshShell.Popup("����\n"+Root+Key+" ������!",0,
    "������ � ��������",vbInformation+vbOkOnly);
  }

//������ �� ������ ������ ���������
Res=WshShell.Popup("�������� ��������\n"+Root+Key+ValueName+"?",0,
  "������ � ��������",vbQuestion+vbYesNo);
if (Res==vbYes) { //������ ������ ��
  //���������� ����� ��������� ��������
  WshShell.RegWrite(Root+Key+ValueName,SValue,"REG_SZ");
  WshShell.Popup("��������\n"+Root+Key+ValueName+" �������!",0,
    "������ � ��������",vbInformation+vbOkOnly);
  //��������� �������� ���������� ���������
  SRegValue=WshShell.RegRead(Root+Key+ValueName);
  //������� �� ����� ���������� ��������
  WshShell.Popup(Root+Key+ValueName+"="+SRegValue,0,
    "������ � ��������",vbInformation+vbOkOnly);
  }

//������ �� �������� ���������
Res=WshShell.Popup("������� ��������\n"+Root+Key+ValueName+"?",0,
  "������ � ��������",vbQuestion+vbYesNo);
if (Res==vbYes) { //������ ������ ��
  //������� ��������
  WshShell.RegDelete(Root+Key+ValueName);
  WshShell.Popup("��������\n"+Root+Key+ValueName+" ������!",0,
    "������ � ��������",vbInformation+vbOkOnly);
  }

//������ �� �������� �������
Res=WshShell.Popup("������� ������\n"+Root+Key+"?",0,
  "������ � ��������",vbQuestion+vbYesNo);
if (Res==vbYes) {  //������ ������ ��
  //������� ������
  WshShell.RegDelete(Root+Key);
  WshShell.Popup("������\n"+Root+Key+" ������!",0,
    "������ � ��������",vbInformation+vbOkOnly);
  }
/*************  ����� *********************************************/
