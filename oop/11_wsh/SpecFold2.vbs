'******************************************************************
' ���: SpecFold2.vbs
' ����: VBScript
' ��������: ����� �������� �������� ����������� ����� Windows
'******************************************************************
Option Explicit

Dim WshShell, WshFldrs, s   ' ��������� ����������
' ������� ������ WshShell
Set WshShell = WScript.CreateObject("Wscript.Shell")
' ������� ������ WshSpecialFolders
Set WshFldrs = WshShell.SpecialFolders
' ��������� ������ � ������ � ���������� ����������� ������
s="��������� ����������� �����:" & vbCrLf & vbCrLf
s=s+"Desktop:"+WshFldrs("Desktop") & vbCrLf
s=s+"Favorites:"+WshFldrs("Favorites") & vbCrLf
s=s+"Programs:"+WshFldrs("Programs")
WScript.Echo s   ' ������� �������������� ������ �� �����
'*************  ����� *********************************************/
