'*******************************************************************
' ���: ListLogProperties.vbs
' ����: VBScript
' ��������: ����� ������� ������� ������� �������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim colLogFiles       ' ��������� ����������� ������ WMI
Dim objLogFile        ' ������� ���������
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
strResult = "�������� ������� ������� System: " & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_ 
                           strComputer & "\" & strNamespace) 
' ������� ��������� ����������� ������ Win32_NTEventLogFile
Set colLogFiles = objService.ExecQuery _
   ("SELECT * FROM Win32_NTEventLogFile WHERE LogFileName='System'")
    
' ���������� �������� ���������     
For Each objLogFile In colLogFiles
  ' ��������� ������ ��� ������ ����  
  strResult = strResult & VbCrLf  &_    
     "Caption: " & objLogFile.Caption & VbCrLf &_ 
     "Compressed: " & objLogFile.Compressed & VbCrLf &_
     "CreationDate: " & WMIDateStr(objLogFile.CreationDate) & VbCrLf &_ 
     "CSName: " & objLogFile.CSName & VbCrLf &_ 
     "Description: " & objLogFile.Description & VbCrLf &_ 
     "Drive: " & objLogFile.Drive & VbCrLf &_ 
     "Extension: " & objLogFile.Extension & VbCrLf &_
     "FileName: " & objLogFile.FileName & VbCrLf &_ 
     "FileSize: " & objLogFile.FileSize & VbCrLf &_ 
     "FileType: " & objLogFile.FileType & VbCrLf &_ 
     "FSName: " & objLogFile.FSName & VbCrLf  &_
     "Hidden: " & objLogFile.Hidden & VbCrLf &_ 
     "InstallDate: " & WMIDateStr(objLogFile.InstallDate) & VbCrLf &_ 
     "LastAccessed: " & WMIDateStr(objLogFile.LastAccessed) & VbCrLf &_ 
     "LastModified: " & WMIDateStr(objLogFile.LastModified) & VbCrLf &_ 
     "LogfileName: " & objLogFile.LogfileName & VbCrLf &_ 
     "MaxFileSize: " & objLogFile.MaxFileSize & VbCrLf &_ 
     "Name: " & objLogFile.Name & VbCrLf &_ 
     "NumberOfRecords: " & objLogFile.NumberOfRecords & VbCrLf &_ 
     "OverwriteOutDated: " & objLogFile.OverwriteOutDated & VbCrLf &_
     "OverWritePolicy: " & objLogFile.OverWritePolicy & VbCrLf &_
     "Path: " & objLogFile.Path & VbCrLf &_ 
     "Status: " & objLogFile.Status 
 Next

' ������� ��������� �� �����
WScript.Echo strResult
'************************* ����� **********************************
