'*******************************************************************
' ���: StartProcessAdd.vbs
' ����: VBScript
' ��������: ������ ������ �������� � ������� ���� � ������� �����������
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer          ' ��� ����������
Dim strNamespace         ' ��� ������������ ����
Dim objService           ' ������ SWbemServices    
Dim objProcess           ' ������ SWbemObject (����� Win32_Process)
Dim objStartup           ' ������ SWbemObject (����� Win32_ProcessStartup)
Dim objConfig            ' ������ SWbemObject (��������� ������
                         '   Win32_ProcessStartup)
Dim intError             ' ��������, ������������ �������
Dim intProcessID         ' ������������� ���������� ��������

' ���������� ���������
Const HIDDEN_WINDOW = 12
Const ABOVE_NORMAL = 32768

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)

' ������� ����� ��������� ������ Win32_ProcessStartup
Set objStartup = objService.Get("Win32_ProcessStartup")
Set objConfig = objStartup.SpawnInstance_

' ������������� ����� ������� � ������� ����
objConfig.ShowWindow = HIDDEN_WINDOW
' ������������� ��������� "���� ��������"
objConfig.PriorityClass = ABOVE_NORMAL

' ������� ������ �� ����� WMI 
Set objProcess = GetObject("WinMgmts:\\" & _
          strComputer & "\" & strNamespace & ":Win32_Process")

' ��������� ����� Create
intError = objProcess.Create _
    ("Notepad.exe", null, objConfig, intProcessID)

' ��������� ������������ ������� ��������
If intError <> 0 Then
  ' ������� �� ����� ��������� �� ������
  WScript.Echo "��� �������� �������� NOTEPAD.EXE ��������� ������"
Else
  ' ������� �� ����� ��������� �� ������� �������
  WScript.Echo "������� NOTEPAD.EXE ������� �������. "
End If
'************************* ����� ***********************************
