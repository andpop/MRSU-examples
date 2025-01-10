'*******************************************************************
' ���: ListEvent_Blue_Screen.vbs
' ����: VBScript
' ��������: ����� � ������� ���� ������� ����� �������
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
strResult = "������� ����� �������: " & VbCrLf & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_ 
                           strComputer & "\" & strNamespace) 
' ������� ��������� ����������� ������ Win32_NTLogEvent
Set colEvents = objService.ExecQuery _
    ("SELECT * FROM Win32_NTLogEvent WHERE Logfile = 'System'" _
                              & " and SourceName = 'SaveDump'")
' ���������� �������� ��������� 
For Each objEvent In colEvents
  ' �������� ������ ��� ������ �� ����� 
  strResult = strResult & "  Event date: " &_
              WMIDateStr(objEvent.TimeGenerated) &_
              "  Description: " & objEvent.Message &_
              VbCrLf & VbCrLf
Next

' ������� ��������� �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
