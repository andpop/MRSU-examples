'*******************************************************************
' ���: Reboot.vbs
' ����: VBScript
' ��������: ������������ ����������
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colInstances      ' ��������� ����������� ������ WMI
Dim objInstance       ' ������� ���������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"

' �������� ��������� �� ����� WMI
Set objClass = GetObject("WinMgmts:{(Shutdown,RemoteShutdown)}\\" &_ 
               strComputer & "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_OperatingSystem
Set colInstances = objClass.Instances_

' ���������� �������� ��������� 
For Each objInstance In colInstances
  ' ������� �� ����� ��������������
  WScript.Echo "��������� " &  objInstance.CSNAME &_
               " ����� ������������ "  
  ' ��� ������� ���������� �������� ����� Reboot
  objInstance.Reboot()
Next
'************************* ����� ***********************************
