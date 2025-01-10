'*******************************************************************
' ���: StdIn2.vbs
' ����: VBScript
' ��������: ������ ������������� ������ StdIn.ReadAll
'*******************************************************************
Option Explicit
' ������� ��� �������� ������ �� DOS- � Windows-���������
Function DosToWin(s)
Dim i,k,ss
  ss=""
  For i=1 To Len(s)  ' ���� �� ���� �������� � ������
    k = Asc(Mid(s,i,1))  ' ���������� ANSI-��� i-�� �������
    ' �������� ��� k �� ��� ���������������� ������� �
    ' Windows-���������
    If (128 <= k) And (k <= 175) Then
      k=k+64
    ElseIf (224 <= k) And (k <= 239) Then
      k=k+16
    ElseIf k = 240 Then
      k=168
    ElseIf k = 241 Then
      k=184
    End If
    ss=ss+Chr(k)
  Next
  DosToWin=ss   ' ���������� ��������������� ������
End Function

'*************  ������ *********************************************
Dim s,ArrS,i,ColStr   ' ��������� ����������
' �������� ����������� ��� �����
WScript.StdOut.WriteLine "������� ������:"
s = WScript.StdIn.ReadAll  ' ������ ������ � ����������
WScript.StdOut.WriteBlankLines 3  ' �������� ������ ������
ArrS=Split(s,vbCrLf)  ' ��������� ������ �� ��������� �����
ColStr=UBound(ArrS)+1
' �������� ��������� ������
WScript.StdOut.WriteLine "����� ������ �����: " & ColStr
For i=1 To ColStr
  ' ��������������� ��������� ������ � Windows-���������
  ' � ������� �� �� �����
  WScript.StdOut.WriteLine i & ": " & DosToWin(ArrS(i-1))
Next
'*************  ����� *********************************************/
