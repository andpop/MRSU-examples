'*******************************************************************
' ���: ListAllEventsWithCode.vbs
' ����: VBScript
' ��������: ����� ���� ������� � ����� 7036 �� ������� ������� ������� 
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim QueryDate         ' ������������� ����
Dim objService        ' ������ SWbemService
Dim colEvents         ' ��������� ����������� ������ WMI
Dim objEvent          ' ������� ���������
Dim strResult         ' ��������� �������
Dim WshShell          ' ������ WshShell
Dim theNotepad        ' ������ WshScriptExec

' ��������� ���������
Const ForWriting = 2

' ��������� ��� ������ ���������� � ���� 
Sub TextOut (Text, File)
  ' ��������� ����������
  Dim  objFSO, FOut 
  ' ������� ������ FileSystemObject
  Set  objFSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' ��������� �������� ���� ��� ������
  Set  FOut = objFSO.OpenTextFile (File,ForWriting,true)
  ' ���������� ��������� ������ � ����
  FOut.WriteLine Text
  ' ��������� �������� ����
  FOut.Close
End Sub

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
strResult = "������� ������� :" & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_ 
                           strComputer & "\" & strNamespace) 
' ������� ��������� ����������� ������ Win32_NTLogEvent
Set colEvents = objService.ExecQuery _
    ("SELECT * FROM Win32_NTLogEvent WHERE (Logfile ='System')" &_
    " and (EventCode = '7036')")
    
' ���������� �������� ���������     
For Each objEvent in colEvents
  ' ��������� ������ ��� ������ ����  
  strResult = strResult & VbCrLf &_ 
              "  Logfile: " & objEvent.Logfile & VbCrLf &_ 
      VbTab & "  Category: " & objEvent.Category & VbCrLf &_ 
      VbTab & "  Computer Name: " & objEvent.ComputerName & VbCrLf &_ 
      VbTab & "  Event Code: " & objEvent.EventCode & VbCrLf &_ 
      VbTab & "  Message: " & objEvent.Message &_ 
      VbTab & "  Record Number: " & objEvent.RecordNumber & VbCrLf &_ 
      VbTab & "  Source Name: " & objEvent.SourceName & VbCrLf &_ 
      VbTab & "  Time Written: " &_
                 WMIDateStr(objEvent.TimeWritten) & VbCrLf &_ 
      VbTab & "  Event Type: " & objEvent.Type & VbCrLf &_ 
      VbTab & "  User: " & objEvent.User & VbCrLf
Next

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\ListEvent.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\ListEvent.txt" )
'************************* ����� ***********************************
