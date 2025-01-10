'*******************************************************************
' ���: MonitorNotepadRun.vbs
' ����: VBScript
' ��������: ���������� ������� �������� 
'*******************************************************************
 Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ���� WMI
Dim objService        ' ������ SWbemServices    
Dim objEventSource    ' ������ SWbemEventSource
Dim objEvent          ' ������ SWbemObject 
Dim strResult         ' �������������� ������

' ��������� ��� ������� ������ �������� �����
Const ForAppend = 8

' ��������� ��� ������ ���������� � ���� 
Sub TextOut (Text, File)
  ' ��������� ����������
  Dim  FSO, FOut 
  ' ������� ������ FileSystemObject
  Set  FSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' ��������� �������� ���� ��� ������
  Set  FOut = FSO.OpenTextFile (File,ForAppend,true)
  ' ���������� ��������� ������ � ����
  FOut.WriteLine Text
  ' ��������� �������� ����
  FOut.Close
End Sub

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
Wscript.Echo " ����������� ������ ������� ��������"

' ���������� � ���������� objEvent ��������� �������
Set objEvent = objEventSource.NextEvent

' �������� ������ ��� ������        
strResult = "������� ������� " & Date & " � " & Time
    
' ������� ��������� �� �����
WScript.Echo strResult
           
' ������� ��������� � ��������� ����
TextOut  "*****************************" & vbCrLf & strResult &_
         "*****************************", "C:\LogNotepad.txt" 
'************************* ����� ***********************************
