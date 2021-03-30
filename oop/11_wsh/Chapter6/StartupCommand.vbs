'*******************************************************************
' ���: StartupCommand.vbs
' ����: VBScript
' ��������: ����� ������ ������, ����������� ��� �������� ����������
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colStartupCommands' ��������� ����������� ������ WMI
Dim objStartupCommand ' ������� ���������
Dim strResult         ' ������ ��� ������ �� �����

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_StartupCommand"
strResult = "�������� ����������� ��� �������� ���������� :" & VbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_StartupCommand
Set colStartupCommands = objClass.Instances_

' ���������� �������� ��������� 
For Each objStartupCommand in colStartupCommands
  strResult = strResult & objStartupCommand.Command & VbCrLf  
Next

' ������� ��������� �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
