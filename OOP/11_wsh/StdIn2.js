/*******************************************************************/
/* ���: StdIn2.js                                                  */
/* ����: JScript                                                   */
/* ��������: ������ ������������� ������ StdIn.ReadAll             */
/*******************************************************************/
var RusDict;

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
    if (RusDict.Exists(s.charAt(i)))  //��������� ������� ������� � �������
      //����������� i-� ������ � Windows-���������
      ss+=RusDict.Item(s.charAt(i));
    else
      ss+=s.charAt(i);
    }
  return ss;
  }
/*************  ������ *********************************************/
var s,ArrS,i;  //��������� ����������
//�������� ����������� ��� �����
WScript.StdOut.WriteLine("������� ������:");
s = WScript.StdIn.ReadAll();  //������ ������ � ����������
WScript.StdOut.WriteBlankLines(3);  //�������� ������ ������
ArrS=s.split("\n");  //��������� ������ �� ��������� �����
WScript.StdOut.WriteLine("����� ������ �����: "+ArrS.length);
for (i=1;i<=ArrS.length;i++)
  //��������������� ��������� ������ � Windows-���������
  //� ������� �� �� �����
  WScript.StdOut.WriteLine(i+": "+DosToWin(ArrS[i-1]));
/*************  ����� *********************************************/
