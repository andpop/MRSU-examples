/*******************************************************************/
/* ���: PrintInWord.js                                             */
/* ����: JScript                                                   */
/* ��������: ������������� �� �������� �������� �������            */
/*           ������������� (Microsoft Word)                        */
/*******************************************************************/
var WA,WD,Sel;  //��������� ����������

//������� ������--���������� Microsoft Word
WA=WScript.CreateObject("Word.Application");
//����� ���� ������������ �����������
//WA=new ActiveXObject("Word.Application");

WD=WA.Documents.Add();  //������� ����� �������� (������ Document)
WA.Visible=true;  //������ Word �������
Sel=WA.Selection;  //������� ������ Selection
Sel.Font.Size=14;  //������������� ������ ������
Sel.ParagraphFormat.Alignment=1;  //������������ �� ������
Sel.Font.Bold=true;  //������������� ���������� �����
Sel.TypeText("������!\n"); //�������� ������ ������
Sel.Font.Bold=false; //�������� ���������� �����
Sel.ParagraphFormat.Alignment=0;  //������������ �� ������ ����
//�������� ������ ������
Sel.TypeText("��� ������ ���������� � ������� WSH.");
WD.PrintOut();   //������� �������� �� �������
/*************  ����� *********************************************/
