'*******************************************************************
' ���: ExecWinApp.vbs
' ����: VBScript
' ��������: ������ � �������� ���������� (������ WshScriptExec)
'*******************************************************************
Option Explicit

Dim WshShell,theNotepad,Res,Text,Title   ' ��������� ����������
' ������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
WScript.Echo "��������� �������"
' ��������� ���������� (������� ������ WshScriptExec)
Set theNotepad = WshShell.Exec("notepad")
WScript.Sleep 500   ' ���������������� ���������� ��������
Text="������� ������� (Status=" & theNotepad.Status & ")" & vbCrLf _
      & "������� �������?"
Title=""
' ������� ���������� ���� �� �����
Res=WshShell.Popup(Text,0,Title,vbQuestion+vbYesNo)
' ����������, ����� ������ ������ � ���������� ����
If Res=vbYes Then
  theNotepad.Terminate ' ��������� ������ ��������
  ' ���������������� ���������� �������� ��� ����, ����� �������
  ' ����� ���������
  WScript.Sleep 100
  WScript.Echo "������� ������ (Status=" & theNotepad.Status & ")"
End If
'*************  ����� *********************************************
