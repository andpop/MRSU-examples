'*******************************************************************
' ���: Run&ExecWinApp.vbs
' ����: VBScript
' ��������: ������ ���� ���������� � ����� ������� ����� ����
'*******************************************************************
Option Explicit

Dim WshShell, theCalculator  ' ��������� ����������
' ������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
WScript.Echo("��������� ����������� �" & vbCrLf & "������� 1+2")
' ������� ������ WshScript (��������� �����������)
Set theCalculator = WshShell.Exec("calc")
' ���������������� ���������� ��������, ��� ����, �����
' ���� ������������ ������ ��������� �� ������
WScript.Sleep 500
' ������������ ���� ������������
WshShell.AppActivate theCalculator.ProcessID
' �������� ������� ������ � ���� ������������
WshShell.SendKeys "1{+}"
WshShell.SendKeys "2"
WshShell.SendKeys "~"    ' ������� <Enter>
WScript.Sleep 500
' �������� ��������� ���������� � ����� Windows (<Ctrl>+C)
WshShell.SendKeys "^c"
' ������� ��������� (�������� ���� ��������)
WScript.Echo "��������� �����������"
' ������������ ���� ������������
WshShell.AppActivate theCalculator.ProcessID
' ��������� ���� ������������ (<Alt>+<F4>)
WshShell.SendKeys "%{F4}"
WScript.Echo "��������� ������� � �������� ���� ���������"
WshShell.Run "notepad"     ' ��������� �������
' ���������������� ���������� ��������, ��� ����, �����
' ���� �������� ������ ��������� �� ������
WScript.Sleep 1000
WshShell.AppActivate "notepad"    ' ������������ ���� ��������
' �������� ������� ������ � ���� ��������
WshShell.SendKeys "1{+}2="
' ��������� ���������� ������ Windows (<Ctrl>+V)
WshShell.SendKeys "^v"
' ������� � ���� �������� ���������� ����������
WshShell.SendKeys " {(}c{)} Calculator"
'*************  ����� *********************************************
