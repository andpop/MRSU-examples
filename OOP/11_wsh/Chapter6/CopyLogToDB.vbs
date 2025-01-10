'*******************************************************************
' ���: CopyLogToDB.vbs
' ����: VBScript
' ��������: ����������� ������� �� ������� ������� � ���� ������
'*******************************************************************
Option Explicit
On Error Resume Next

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim colEvents         ' ��������� ����������� ������ WMI
Dim objEvent          ' ������� ���������
Dim strSQLCommand     ' ������ ��� �������� �������
Dim objConnect        ' ������ ADODB.Connection
Dim objRecordset      ' ������ ADODB.Recordset

' ��������� ���������
const adExecuteNoRecords = &H80
const adUseClient = 3
const adOpenStatic = 3
const adLockOptimistic = 3

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
' SQL-������� ��� �������� ������� ��� ������� �� �������� �������
strSQLCommand = "CREATE TABLE EVENTLOGS ( " &_
                " LogFile varchar (20),   " &_
                " Category varchar (20),  " &_
                " CompName varchar (50),  " &_
                " EventCode varchar (20), " &_
                " Message varchar(254) ,  " &_
                " RecNumber varchar (10), " &_
                " Source varchar (50),    " &_
                " TimeRec varchar (50),   " &_
                " Type varchar (20),      " &_
                " User varchar (50)       " &_
                " ) " 
' ������� ������ ADODB.Connection
Set objConnect = CreateObject("ADODB.Connection")
' ������� ������ ADODB.Recordset
Set objRecordset = CreateObject("ADODB.Recordset")

' ������������� ���������� � ���������� ������
objConnect.Open "DSN=EventLog_DBF;"

' ������� ����� ������� ��� �������� �������
objConnect.Execute strSQLCommand,,adExecuteNoRecords
' ������������ ������
if Err.Number = 0 then  
  ' ������� ��������� �� �������� �������
  MsgBox "������� ������� EVENTLOGS " 
end if

objRecordset.CursorLocation = adUseClient

' ��������� ����� ������
objRecordset.Open "SELECT * FROM EVENTLOGS" , objConnect, _
                             adOpenStatic, adLockOptimistic
' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_ 
                           strComputer & "\" & strNamespace) 

' ������� ��������� ����������� ������ Win32_NTLogEvent
Set colEvents = objService.ExecQuery _
                          ("SELECT * FROM Win32_NTLogEvent")
' ���������� �������� ���������     
For Each objEvent In colEvents
  ' ��������� ����� ������  
  objRecordset.AddNew
  ' ��������� ���� ������
  objRecordset("LogFile") = objEvent.LogFile
  objRecordset("Category") = objEvent.Category
  objRecordset("CompName") = objEvent.ComputerName
  objRecordset("EventCode") = objEvent.EventCode
  objRecordset("Message") = left (objEvent.Message,254)
  objRecordset("RecNumber") = objEvent.RecordNumber
  objRecordset("Source") = objEvent.SourceName
  objRecordset("TimeRec") = WMIDateStr(objEvent.TimeWritten)
  objRecordset("Type") = objEvent.Type
  objRecordset("User") = objEvent.User
  ' ��������� ������
  objRecordset.Update
Next

' ������� ������ ADODB.Recordset
objRecordset.Close
' ������� ������ ADODB.Connection
objConnect.Close

' ������� ��������� �� ���������� ����������� ������
WScript.Echo "����������� ������ ������� ���������"
'************************* ����� ***********************************
