/********************************************************************/
/* ���: ListProcesses.js                                            */
/* ����: JScript                                                    */
/* ��������: ����� �� ����� ������ ���� ���������� �� ���������     */
/*           ������� ������� ���������                              */
/********************************************************************/
var 
  WMI,                  //��������� WMI
  Processes,            //��������� ���������
  Process,              //��������� ���������
  SList;                //������ ��� ������ �� �����

var vbCritical=16;

try  {
  //����������� � WMI
  WMI=GetObject("winMgmts:");
  }
catch (e) {  //������������ ��������� ������
  if (e != 0) {
    Mess="������ ��� ���������� � WMI";
    WshShell.Popup(Mess,0,"���������� ��������",vbCritical);
    WScript.Quit();
    }
  }

Processes=new Enumerator(WMI.ExecQuery("SELECT * FROM Win32_Process"));
SList="���������� ��������\n\n";

//���� �� ���� ��������� ���������
while (!Processes.atEnd()) {
  Process=Processes.item();
  SList+=Process.Name+"\n";
  Processes.moveNext();
  }

WScript.Echo(SList);

