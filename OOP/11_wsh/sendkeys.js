/*******************************************************************/
/* ���: Run&ExecWinApp.js                                          */
/* ����: JScript                                                   */
/* ��������: ������ ���� ���������� � ����� ������� ����� ����     */
/*******************************************************************/
var WshShell, theCalculator;  //��������� ����������
//������� ������ WshShell
WshShell = WScript.CreateObject("WScript.Shell");
WScript.Echo("��������� ����������� �\n ������� 1+2");
//������� ������ WshScript (��������� �����������)
theCalculator = WshShell.Exec("calc");
//���������������� ���������� �������� ��� ����,
//����� ���� ������������ ������ ��������� �� ������
WScript.Sleep(1000);
//������������ ���� ������������
WshShell.AppActivate(theCalculator.ProcessID);
//�������� ������� ������ � ���� ������������
WshShell.SendKeys("1{+}");
WshShell.SendKeys("2");
WshShell.SendKeys("~");  //������� <Enter>
WScript.Sleep(1000);
//�������� ��������� ���������� � ����� Windows (<Ctrl>+C)
WshShell.SendKeys("^c");
//������� ��������� (�������� ���� ��������)
WScript.Echo("��������� �����������");
//������������ ���� ������������
WshShell.AppActivate(theCalculator.ProcessID);
//��������� ���� ������������ (<Alt>+<F4>)
WshShell.SendKeys("%{F4}");
WScript.Echo("��������� ������� � �������� ���� ���������");
WshShell.Run("notepad"); //��������� �������
//���������������� ���������� ��������, ��� ����, �����
//���� �������� ������ ��������� �� ������
WScript.Sleep(1000);
WshShell.AppActivate("notepad"); //������������ ���� ��������
//�������� ������� ������ � ���� ��������
WshShell.SendKeys("1{+}2=");
//��������� ���������� ������ Windows (<Ctrl>+V)
WshShell.SendKeys("^v");
//������� � ���� �������� ���������� ����������
WshShell.SendKeys(" {(}c{)} Calculator");
/*************  ����� *********************************************/
