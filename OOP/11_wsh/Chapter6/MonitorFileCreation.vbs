'*******************************************************************
' ���: MonitorFileCreation.vbs
' ����: VBScript
' ��������: �������� �� ������� �������� ����� � ����� C:\TEST 
'           � ����������� ������ 
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ���� WMI
Dim objService        ' ������ SWbemServices    
Dim strResult         ' ��������� �������
Dim objSink           ' ������ SWbemSink
Dim bDone             ' ����������-���� ������ �� �����

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"

' ������������ � ������������ ����
Set objService = GetObject("WinMgmts:\\" & _
                            strComputer & "\" & strNamespace)
' ������� ������ SWbemSink
Set objSink = wscript.CreateObject("WbemScripting.SWbemSink", "Sink_")

' ��������� ����� ExecMethodAsync_
objService.ExecNotificationQueryAsync objSink, _
       "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE " &_
       "Targetinstance ISA 'CIM_DirectoryContainsFile' and " &_
       "TargetInstance.GroupComponent= " &_
       "'Win32_Directory.Name=""C:\\\\TEST""'"

' ������� ��������� � ������� �������
Wscript.Echo " ������� ������ �������� ����� � ����� C:\TEST"

' ���������������� �������� �� ���������� ���������� �������
While Not bDone    
  WScript.Sleep 1000
Wend

' ��������� - ���������� ������� OnObjectReady ������� sWbemSink
Sub Sink_OnObjectReady(oOutParams, oContext)
  ' �������� ������ ��� ������        
  strResult = Date & " " & Time & vbCrLf &_
  "������ ����: " &  oOutParams.TargetInstance.PartComponent
    
  ' ������� ��������� �� �����
  Wscript.Echo strResult

  bDone = True         
End Sub
'************************* ����� ***********************************
