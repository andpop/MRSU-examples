/*******************************************************************/
/* ���: ExecConApp.js                                              */
/* ����: JScript                                                   */
/* ��������: ������ ��������� ����������� ����������               */
/*******************************************************************/
//��������� ����������
var ObjExec,WshShell,s,IsBreak,ArrS,ColStr,ColFiles,i;
//������� ������ WshShell
WshShell = WScript.CreateObject("WScript.Shell");
//��������� ������� DIR
ObjExec=WshShell.Exec("%COMSPEC% /c dir /b");
s="";
IsBreak=false;
for (;;) {  //����������� ����
  //���������, ��������� �� ����� ��������� ������ ������� DIR
  if (!ObjExec.StdOut.AtEndOfStream)
    //��������� ��������� �������� ����� ������� DIR
    s+=ObjExec.StdOut.ReadAll();
  if (IsBreak)
    break; //������� �� �����
  if (ObjExec.Status==1)  //���������, �� ����������� �� ���������� DIR
    IsBreak=true;
  else
    WScript.Sleep(100);  //���������������� �������� �� 0,1 ���
  }
ArrS=s.split("\n");  //��������� ������ �����
ColFiles=ArrS.length-1;   // ���������� ������ � ������� ��������
WScript.StdOut.WriteLine("����� ������ � ������� ��������: "+ColFiles);
for (i=0;i<=ColFiles-1;i++)
  WScript.StdOut.WriteLine(ArrS[i]); //������� ������ �� �����
/*************  ����� *********************************************/
