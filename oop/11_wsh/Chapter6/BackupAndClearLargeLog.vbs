'*******************************************************************
' ���: BackupAndClearLargeLog.vbs
' ����: VBScript
' ��������: �������������� � ������� �������� �������, 
'           ������ ������� ��������� 500 Kb
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
Set objService = GetObject("WinMgmts:{(Backup,Security)}\\" &_ 
                            strComputer & "\" & strNamespace) 
     
' ������� ��������� ����������� ������ Win32_NTEventLogFile
Set colLogFiles = objService.ExecQuery _
    ("SELECT * FROM Win32_NTEventLogFile WHERE FileSize > 500000")
    
' ���������� �������� ��������� 
For Each objLogFile In colLogFiles
  ' ����������� ������ ������� ���������� � ����� c:\application.evt
  iError = objLogFile.BackupEventLog("c:\" &_
                      objLogFile.LogFileName  & ".evt")
  ' ������������ ������ ������������ ������� BackupEventLog
  If iError <> 0 Then        
    ' ������� ��������� �� ������
    Wscript.Echo "������ ������� " & objLogFile.LogFileName &_
                 " �� ����� ���� ��������."
  Else
    ' ������� ������ ������� 
    iError = objLogFile.ClearEventLog()
      
    ' ������������ ������, ������������ ������� ClearEventLog
    If iError <> 0 Then 
      ' ������� ��������� �� ������
      Wscript.Echo "������ ������� " & objLogFile.LogFileName &_
                   " �� ����� ���� ������."
      Else
        ' ������� ��������� �� �������� ����������
        Wscript.Echo "������ ������� " & objLogFile.LogFileName &_
                     " �������� � ������."        
    End If
  End If
Next
'************************* ����� ***********************************
