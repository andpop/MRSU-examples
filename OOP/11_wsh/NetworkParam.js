/********************************************************************/
/* ���: NetworkParam.js                                             */
/* ����: JScript                                                    */
/* ��������: ����� ������� ���������� �������                       */
/********************************************************************/
var WshNetwork,s; //��������� ����������

//������� ������ WshNetwork
WshNetwork = WScript.CreateObject("WScript.Network");

s="������� ��������� �������:\n\n";
//������� �� ����� �������� ComputerName, UserName � UserDomain
s+="��� ������: "+WshNetwork.ComputerName+"\n";
s+="��� ������������: "+WshNetwork.UserName+"\n";
s+="�����: "+WshNetwork.UserDomain;
WScript.Echo(s);
/*************  ����� *********************************************/
