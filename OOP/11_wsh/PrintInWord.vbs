'*******************************************************************
' ���: PrintInWord.vbs
' ����: VBScript
' ��������: ������������� �� �������� �������� �������
'           ������������� (Microsoft Word)
'*******************************************************************
Option Explicit

Dim WA,WD,Sel  ' ��������� ����������
'������� ������--���������� Microsoft Word
Set WA=WScript.CreateObject("Word.Application")
' ����� ���� ������������ �����������
' Set WA=CreateObject("Word.Application")

Set WD=WA.Documents.Add  '������� ����� �������� (������ Document)
WA.Visible=true  ' ������ Word �������
Set Sel=WA.Selection  '������� ������ Selection
Sel.Font.Size=14 '������������� ������ ������
Sel.ParagraphFormat.Alignment=1  '������������ �� ������
Sel.Font.Bold=true  '������������� ���������� �����
Sel.TypeText "������!" & vbCrLf  '�������� ������ ������
Sel.Font.Bold=false  '�������� ���������� �����
Sel.ParagraphFormat.Alignment=0  '������������ �� ������ ����
'�������� ������ ������
Sel.TypeText "��� ������ ���������� � ������� WSH."
WD.PrintOut   '������� �������� �� �������
'*************  ����� *********************************************
