/********************************************************************/
/* ���: KillNotepads.js                                             */
/* ����: JScript                                                    */
/* ��������: �������� ���� ���������� ����������� ��������          */
/********************************************************************/
var
  WMI,                  //��������� WMI
  SQuery,               //����� �������
  Processes,            //��������� ���������
  Process,              //��������� ���������
  WshShell;             //������ WshShell
//�������������� ��������� ��� ���������� ����
var vbCritical=16;

//������� ������ WshShell
WshShell = WScript.CreateObject("WScript.Shell");
    
try  {
  //����������� � WMI
  WMI=GetObject("winMgmts:");
  }
catch (e) {  //������������ ��������� ������
  if (e != 0) {
    //������� ��������� �� ������
    Mess="������ ��� ���������� � WMI";
    WshShell.Popup(Mess,0,"�������� ���� ���������",vbCritical);
    //������� �� ��������
    WScript.Quit();
    }
  }
  
//��������� ����� �������  
SQuery="SELECT * FROM Win32_Process WHERE Name='Notepad.exe'"
//������� ���������-��������� �������
Processes=new Enumerator(WMI.ExecQuery(SQuery));

//���� �� ���� ��������� ���������
while (!Processes.atEnd()) {
  //��������� ������� ������� ��������� (������� � ������ Notepad.exe)
  Process=Processes.item();
  try  {  
    //��������� �������
    Process.Terminate();
    }
  catch (e) {  //������������ ��������� ������
    if (e != 0) {
      //������� ��������� �� ������
      Mess="������ ��� �������� �������� ����������";
      WshShell.Popup(Mess,0,"�������� ���� ���������",vbCritical);
      }
    }
  //��������� � ���������� �������� ���������  
  Processes.moveNext();
  }

