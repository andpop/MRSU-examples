'*****************************************************************
' ���: Shortcut.vbs
' ����: JScript
' ��������: �������� ������� � ����������� ������
'*****************************************************************
Option Explicit

' ��������� ����������
Dim WshShell,MyShortcut,PathTarg,PathIcon,Res,PathShortcut

' ������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
' ������� ������ ��� ������ �����, � ������� ����� ������ �����
Res=WshShell.Popup("��� ������� �����?" & vbCrLf & "��  - �� ������� �����" & vbCrLf & _
  "��� - � ���� ���������",0,"������ � ��������",vbQuestion+vbYesNo)
If Res=vbYes Then  ' ������ ������ ��
  ' ���������� ���� � �������� �����
  PathShortcut = WshShell.SpecialFolders("Desktop")
Else
  ' ���������� ���� � ���� ���������
  PathShortcut = WshShell.SpecialFolders("Programs")
End If

' ������� ������-�����
Set MyShortcut = WshShell.CreateShortcut(PathShortcut+"\��� �����.lnk")
' ������������� ���� � �����
PathTarg=WshShell.ExpandEnvironmentStrings("%windir%\\notepad.exe")
MyShortcut.TargetPath = PathTarg
' ��������� ���������� ������� ������
MyShortcut.Hotkey = "CTRL+ALT+N"
' �������� ������ �� ����� SHELL32.dll
PathIcon = _
  WshShell.ExpandEnvironmentStrings("%windir%\system32\SHELL32.dll")
MyShortcut.IconLocation = PathIcon & ", 1"
MyShortcut.WindowStyle=3  ' ������������� ��� ���� (���������������)
MyShortcut.Save   ' ��������� �����
WScript.Echo "����� ������|"
'*************  ����� *********************************************
