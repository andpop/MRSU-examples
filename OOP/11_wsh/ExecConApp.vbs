'*******************************************************************
' ���: ExecConApp.vbs
' ����: VbScript
' ��������: ������ ��������� ����������� ����������
'*******************************************************************
Option Explicit
' ��������� ����������
Dim ObjExec,WshShell,s,IsBreak,ArrS,ColStr,ColFiles,i
' ������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
' ��������� ������� DIR
Set ObjExec=WshShell.Exec("%COMSPEC% /c dir /b")
s=""
IsBreak=False
Do While True  ' ����������� ����
  ' ���������, ��������� �� ����� ��������� ������ ������� DIR
  If (Not ObjExec.StdOut.AtEndOfStream) Then
    ' ��������� ��������� �������� ����� ������� DIR
    s=s+ObjExec.StdOut.ReadAll
  End If
  If IsBreak Then
    Exit Do  ' ������� �� �����
  End If
  ' ���������, �� ����������� �� ���������� DIR
  If ObjExec.Status=1 Then
    IsBreak=True
  Else
    WScript.Sleep 100 ' ���������������� �������� �� 0,1 ���
  End If
Loop
ArrS=Split(s,vbCrLf)  ' ��������� ������ �����
ColFiles=UBound(ArrS)  ' ���������� ������ � ������� ��������
WScript.StdOut.WriteLine "����� ������ � ������� ��������: " & ColFiles
For i=0 To ColFiles-1
  WScript.StdOut.WriteLine ArrS(i)  ' ������� ������ �� �����
Next
'*************  ����� *********************************************
