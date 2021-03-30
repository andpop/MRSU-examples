'*******************************************************************
' ���: MonitorEntryLevelEvents.vbs
' ����: VBScript
' ��������: ���������� ��������� � ��������� ������� 
'*******************************************************************
 Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ���� WMI
Dim objService        ' ������ SWbemServices    
Dim objSink           ' ������ SWbemSink
Dim bDone             ' ����������-���� ������ �� �����

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."

' ������������ � ������������ ���� \Root\Default
Set objService = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default") 
' ������� ������ SWbemSink
Set objSink = WScript.CreateObject("WbemScripting.SWbemSink", "SINK_") 

' ��������� ������ ��� �������� �� ��������� � �������� ���������
' �������� ��������� SOFTWARE\Example key\Example String Value
objService.ExecNotificationQueryAsync objSink, _ 
    "SELECT * FROM RegistryValueChangeEvent WHERE " &_
    "Hive='HKEY_LOCAL_MACHINE' AND " &_
    "KeyPath='SOFTWARE\\Example key' AND " &_
    "ValueName='Example String Value'" 

' ������� ��������� � ������� �������
WScript.Echo "������� ������ ��������� � ��������� �������" & vbCrLf 

' ���������������� �������� �� ����������� �������
While Not bDone    
  WScript.Sleep 1000
Wend


' ��������� - ���������� ������� OnObjectReady ������� SWbemSink
Sub Sink_OnObjectReady(oOutParams, oContext)
  ' ������� ��������� � ������������ �������
    Wscript.Echo "��������� ��������� � ��������� �������" & vbCrLf & _ 
     "------------------------------" & vbCrLf & _
     oOutParams.GetObjectText_() 
  bDone = True
End Sub            
'************************* ����� ***********************************
