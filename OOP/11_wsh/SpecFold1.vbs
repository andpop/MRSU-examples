'*****************************************************************
' ���: SpecFold1.vbs
' ����: VBScript
' ��������: ����� �������� ���� ����������� ����� Windows
'*****************************************************************
Option Explicit

Dim WshShell, WshFldrs, SpecFldr, s  ' ��������� ����������
' ������� ������ WshShell
Set WshShell = WScript.CreateObject("Wscript.Shell")
' ������� ������ WshSpecialFolders
Set WshFldrs = WshShell.SpecialFolders
s="������ ���� ����������� �����:" & vbCrLf & vbCrLf
' ���������� ��� �������� ��������� WshFldrs
For Each SpecFldr In WshFldrs
  ' ��������� ������ � ������ � ����������� ������
  s=s & SpecFldr & vbCrLf
Next
WScript.Echo s
'*************  ����� *********************************************/
