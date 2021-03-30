/*******************************************************************/
/* ���: StdIn1.js                                                  */
/* ����: JScript                                                   */
/* ��������: ������ ������������� ������ StdIn.ReadLine            */
/*******************************************************************/
var s,RusDict;  //��������� ����������

//������� ��� �������� ������� Dictionary � ������ "����-��������", ���
//"����" - ����� � DOS-���������,
//"��������" - ������, ��������������� ���� ����� � Windows-���������
function MakeRusDict() {
  //������� ������ Dictionary
  RusDict = WScript.CreateObject("Scripting.Dictionary");
  //��������� ���� "����" (������ � DOS-���������)- "��������" (������ �
  //Window-���������) ��� ���� ���� �������� ��������
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("'", "�"); RusDict.add ("'", "�"); RusDict.add (""", "�");
  RusDict.add (""", "�"); RusDict.add ("o", "�"); RusDict.add ("-", "�");
  RusDict.add ("-", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");

  RusDict.add (" ", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add (""", "�"); RusDict.add ("", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
  RusDict.add ("�", "�"); RusDict.add ("�", "�"); RusDict.add ("�", "�");
}

//������� ��� �������� ������ �� DOS- � Windows-���������
function DosToWin(s) {
  var i,ss;  //��������� ����������
  //���������, ������ �� ������ RusDict
  if (typeof(RusDict)=="undefined")
    //���� ������ RusDict �� ������, ������� ���
    MakeRusDict();
  ss="";
  for (i=0;i<s.length;i++) {  //���� �� ���� �������� � ������
    //��������� ������� ������� � �������
    if (RusDict.Exists(s.charAt(i)))
      //����������� i-� ������ � Windows-���������
      ss+=RusDict.Item(s.charAt(i));
    else
      ss+=s.charAt(i);
    }
  return ss;   //���������� ��������������� ������
  }
/*************  ������ *********************************************/
//�������� ����������� ��� �����
WScript.StdOut.Write("������� ���� ������: ");
s = WScript.StdIn.ReadLine();  //������ ������ � ����������
WScript.StdOut.WriteBlankLines(1);  //�������� ������ ������
WScript.StdOut.Write("���� �������: ");
//��������������� ��������� ������ � Windows-���������
//� ������� �� �� �����
WScript.StdOut.WriteLine(DosToWin(s));
/*************  ����� *********************************************/
