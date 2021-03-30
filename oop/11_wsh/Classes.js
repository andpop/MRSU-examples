//*******************************************************************
// ���: Classes.js
// ����: JScript
// ��������: �������� ���� ������� � ������������ ����
//*******************************************************************
// ��������� ����������
var 
  strComputer,        // ��� ����������
  strResult,          // ��������� (��������� ���������) 
  strNamespace,       // ��� ������������ ����
  WshShell,           // ������ WshShell
  objService,         // ������ SWbemServices
  colClasses,         // ��������� �������
  objClass,           // ������� ���������
  theNotepad;         // ������ WshScriptExec

// ��������� ��� ������� ������ �������� �����
var ForWriting = 2;

// ������� ��� ������ ���������� � ���� 
function TextOut (Text, File) {
  // ��������� ����������
  var FSO, FOut ;
  // ������� ������ FileSystemObject
  FSO = WScript.CreateObject("Scripting.FileSystemObject");
  // ��������� �������� ���� ��� ������
  FOut = FSO.OpenTextFile (File,ForWriting,true);
  // ���������� ��������� ������ � ����
  FOut.WriteLine(Text);
  // ��������� �������� ����
  FOut.Close();
}

//********************** ������ *************************************
// ����������� ��������� �������� ����������
strComputer = ".";
strResult = "";
strNamespace = "Root\\CIMV2";

// ������������ � ������������ ���� WMI
objService = GetObject("winmgmts:\\\\" + strComputer + "\\" + strNamespace);

// ������� ��������� ������� WMI
colClasses = new Enumerator(objService.SubclassesOf());

// ���������� �������� ��������� 
while (!colClasses.atEnd()) {
  //��������� ������� ������� ���������
  objClass = colClasses.item();
  //��������� �������������� ������
  strResult += "  " + objClass.Path_.Class + "\r\n";
  //��������� � ���������� �������� ���������
  colClasses.moveNext();
  }
// ������� ��������� � ���� � ������� ������� TextOut
TextOut (" ������ ������� � ������������ ����  " + strNamespace +
         " : \r\n" + strResult, "C:\\Classes.txt"); 

// ������� ������ WshShell
WshShell = WScript.CreateObject("WScript.Shell");
// ��������� ��������� ���� � ��������
theNotepad = WshShell.Exec("notepad  C:\\Classes.txt" );
//************************* ����� ***********************************
