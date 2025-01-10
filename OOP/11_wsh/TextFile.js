/*******************************************************************/
/* ���: TextFile.js                                                */
/* ����: JScript                                                   */
/* ��������: ������ ����� � ��������� ���� � ������ �� ����        */
/*******************************************************************/
var FSO,F,TextStream,s;  //��������� ����������
//�������������� ���������
var ForReading = 1, 
    ForWriting = 2, 
    TristateUseDefault = -2;

//������� ������ FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//������� � ������� �������� ���� test1.txt
FSO.CreateTextFile("test1.txt"); 
//������� ������ File ��� ����� test1.txt
F=FSO.GetFile("test1.txt");
//������� ������ TextStream (���� ����������� ��� ������)
TextStream=F.OpenAsTextStream(ForWriting, TristateUseDefault);
//���������� � ���� ������
TextStream.WriteLine("��� ������ ������");
//��������� ����
TextStream.Close();
//��������� ���� ��� ������
TextStream=F.OpenAsTextStream(ForReading, TristateUseDefault);
//��������� ������ �� �����
s=TextStream.ReadLine();
//��������� ���� 
TextStream.Close();
//���������� ������ �� ������
WScript.Echo("������ ������ �� ����� test1.txt:\n\n",s);
/*************  ����� *********************************************/
