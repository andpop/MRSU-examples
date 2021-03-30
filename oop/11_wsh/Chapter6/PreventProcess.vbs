'*******************************************************************
' ���: PreventProcess.vbs
' ����: VBScript
' ��������: ������������� �������� ������������ �������� 
'*******************************************************************
 Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ���� WMI
Dim objService        ' ������ SWbemServices    
Dim objEventSource    ' ������ SWbemEventSource
Dim objEvent          ' ������ SWbemObject 
Dim strResult         ' �������������� ������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
' ��������� ������ ��� �������� �� ��������� � �������� WMI 
Set objEventSource = objService.ExecNotificationQuery _
            ("SELECT * FROM __InstanceCreationEvent " & _
             "WITHIN 5 WHERE (TargetInstance ISA 'Win32_Process' " &_
              "AND TargetInstance.Name='NOTEPAD.EXE') ")

' ������� ��������� � ������� �������
Wscript.Echo " ������� ������ ���������"

Do While true
  ' ���������� � ���������� objEvent ��������� �������
  Set objEvent = objEventSource.NextEvent

  '��������� ������ �������� objEvent.TargetInstance
  objEvent.TargetInstance.Terminate
Loop
'************************* ����� ***********************************
