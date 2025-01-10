'*******************************************************************
' ���: MonitorEventLog.vbs
' ����: VBScript
' ��������: ���������� �������� �������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim colEvents         ' ��������� ����������� ������ WMI
Dim objEvent          ' ������� ���������
Dim strResult         ' ��������� �������

' ������� ��� ����������� ���� ������� WMI � ������
Function WMIDateStr(WMIDate)
    WMIDateStr = CDate(Mid(WMIDate, 5, 2) & "." & _
         Mid(WMIDate, 7, 2)  & "." &_
         Left(WMIDate, 4)    & " " &_
         Mid(WMIDate, 9, 2)  & ":" & _
         Mid(WMIDate, 11, 2) & ":" & _
         Mid(WMIDate, 13, 2))
End Function

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strResult = ""

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:{(Security)}!\\" &_ 
                           strComputer & "\" & strNamespace) 
' ��������� ������ ��� �������� �� ��������� � �������� WMI 
Set colEvents = objService.ExecNotificationQuery _
         ("SELECT * FROM __InstanceCreationEvent " &_
          "WITHIN 5 WHERE TargetInstance ISA 'Win32_NTLogEvent'")
' ���������� � ���������� objEvent ��������� �������
Set objEvent = colEvents.NextEvent
' �������� ������ ��� ������ �� �����
strResult = _
  "Record No.: " & objEvent.TargetInstance.RecordNumber & VbCrLf &_
  "Event ID: " & objEvent.TargetInstance.EventCode & VbCrLf &_
  "Time: " &_
       WMIDateStr(objEvent.TargetInstance.TimeWritten) & VbCrLf &_
  "Source: " & objEvent.TargetInstance.SourceName & VbCrLf &_
  "Category: " & _
               objEvent.TargetInstance.CategoryString & VbCrLf &_
  "Event Type: " & objEvent.TargetInstance.Type & VbCrLf &_
  "Computer: " & objEvent.TargetInstance.ComputerName & VbCrLf &_
  "User: " & objEvent.TargetInstance.User & VbCrLf &_
  "Text: " & objEvent.TargetInstance.Message 
   
' ������� ��������� �� �����
WScript.Echo strResult
'************************* ����� ***********************************
