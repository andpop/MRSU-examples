/********************************************************************/
/* ���: MapResources.js                                             */
/* ����: JScript                                                    */
/* ��������: ���������� � ����������� ������� ������ � ���������    */
/********************************************************************/
//��������� ����������
var WshNetwork,WshShell,Drive,NetPath,Port,NetPrinter,Mess,IsError;
//�������������� ��������� ��� ���������� ����
var vbCritical=16,vbInformation=64;

Drive="K:";      //����� �����
NetPath="\\\\RS_NT_Server\\d";  //������� ���� ��� ����������� �����
Port="LPT1";   //�������� ���������� �����
//������� ���� ��� ����������� ��������
NetPrinter="\\\\104_Stepankova\\HP";

//������� ������ WshNetwork
WshNetwork = WScript.CreateObject("WScript.Network");
//������� ������ WshShell
WshShell = WScript.CreateObject("WScript.Shell");

/*************  ���������� �������� �����  ***********************/
IsError=false;
try  {
  //��������� ������� ����
  WshNetwork.RemoveNetworkDrive(Drive);
  }
catch (e) {  //������������ ��������� ������
  if (e != 0) {
    //������� ��������� �� ������
    IsError=true;
    Mess="������ ��� ���������� ����� "+Drive+"\n��� ������: "+
         e.number+"\n��������: "+e.description;
    WshShell.Popup(Mess,0,"���������� �������� �����",vbCritical);
    }
  }
if (!IsError)  {
  //��� � �������
  Mess="���� "+Drive+" �������� �������";
  WshShell.Popup(Mess,0,"���������� �������� �����",vbInformation);
  }

/*************  ����������� �������� �����  ***********************/
IsError=false;
try  {
  //���������� ������� ����
  WshNetwork.MapNetworkDrive(Drive,NetPath);
  }
catch (e) {  //������������ ��������� ������
  if (e != 0) {
    //������� ��������� �� ������
    IsError=true;
    Mess="������ ��� ����������� ����� " + Drive + " � " + NetPath+
         "\n��� ������: "+e.number+"\n��������: "+e.description;
    WshShell.Popup(Mess,0,"����������� �������� �����",vbCritical);
    }
  }
if (!IsError)  {
  //��� � �������
  Mess="���� "+Drive+" ������� ��������� � "+NetPath;
  WshShell.Popup(Mess,0,"����������� �������� �����",vbInformation);
  }

/*************  ������������ ���������� �����  ***********************/
IsError=false;
try  {
  //��������� ����� � ������� ���������
  WshNetwork.RemovePrinterConnection(Port);
  }
catch (e) {
  if (e != 0) {  //������������ ��������� ������
    //������� ��������� �� ������
    IsError=true;
    Mess="������ ��� ���������� ����� "+Port+"\n��� ������: "+
         e.number+"\n��������: "+e.description;
    WshShell.Popup(Mess,0,"���������� ���������� ����� �� �������� �������",vbCritical);
    }
  }
if (!IsError)  {
  //��� � �������
  Mess="���� "+Port+" �������� �������";
  WshShell.Popup(Mess,0,"���������� ���������� ����� �� �������� �������",vbInformation);
  }

/*****  ����������� ���������� �����  � �������� ��������  *********/
IsError=false;
try  {
  //���������� ������� ������� � ���������� �����
  WshNetwork.AddPrinterConnection(Port,NetPrinter);
  }
catch (e) {  //������������ ��������� ������
  if (e != 0) {
    //������� ��������� �� ������
    IsError=true;
    Mess="������ ��� �������������� ����� "+Port+ " �� "+NetPrinter+
                  "\n��� ������: "+e.number+"\n��������: "+e.description;
    WshShell.Popup(Mess,0,"����������� ���������� ����� � �������� �������",vbCritical);
    }
  }
if (!IsError)  {
  //��� � �������
  Mess="���� "+Port+" ������� ��������� � "+NetPrinter;
  WshShell.Popup(Mess,0,"����������� ���������� ����� � �������� �������",vbInformation);
  }
/*************  ����� *********************************************/
