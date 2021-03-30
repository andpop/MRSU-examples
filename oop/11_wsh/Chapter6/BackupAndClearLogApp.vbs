'*******************************************************************
' ���: BackupAndClearLogApp.vbs
' ����: VBScript
' ��������: �������������� � ������� ������� ������� ����������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim colLogFiles       ' ��������� ����������� ������ WMI
Dim objLogFile        ' ������� ���������
Dim iError            ' ��������, ������������ �������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:{(Backup)}\\" &_ 
                            strComputer & "\" & strNamespace) 
' ������� ��������� ����������� ������ Win32_NTEventLogFile
Set colLogFiles = objService.ExecQuery _
    ("SELECT * FROM Win32_NTEventLogFile WHERE LogFileName='Application'")
    
' ���������� �������� ��������� 
For Each objLogFile In colLogFiles
  ' ����������� ������ ������� ���������� � ����� c:\application.evt
  iError = objLogFile.BackupEventLog("c:\application.evt")
  ' ������������ ������, ������������ ������� BackupEventLog
  If iError <> 0 Then        
    ' ������� ��������� �� ������
    Wscript.Echo "������ ������� ���������� �� ����� ���� ��������."
  Else
    ' ������� ������ ������� ����������
    iError = objLogFile.ClearEventLog()
    ' ������������ ������, ������������ ������� ClearEventLog
    If iError <> 0 Then 
      ' ������� ��������� �� ������
      Wscript.Echo "������ ������� ���������� �� ����� ���� ������."
    Else
      ' ������� ��������� �� �������� ����������
      Wscript.Echo "������ ������� ���������� �������� � ������."        
    End If
  End If
Next
'************************* ����� ***********************************
