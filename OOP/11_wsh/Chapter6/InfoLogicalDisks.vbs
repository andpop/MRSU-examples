'*******************************************************************
' ���: InfoLogicalDisks.vbs
' ����: VBScript
' ��������: ��������� ���������� � ���������� ������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim strResult         ' ��������� �������
Dim colLogicalDisks   ' ��������� ����������� ������ WMI
Dim objLogicalDisk    ' ������� ���������
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

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strResult = "���������� �����: " & VbCrLf & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' ������� ��������� ����������� ������ Win32_LogicalDisk
Set colLogicalDisks = objService.ExecQuery _
                    ("Select * from Win32_LogicalDisk")

' ���������� �������� ���������   
For Each objLogicalDisk In colLogicalDisks
  ' ��������� ������ ��� ������ ����    
  strResult = strResult &_
  "    DeviceID: " &  objLogicalDisk.DeviceID & VbCrLf &_
  vbTab & "Compressed: " &  objLogicalDisk.Compressed & VbCrLf &_
  vbTab & "Description: " &  objLogicalDisk.Description & VbCrLf &_
  vbTab & "DriveType: " &  objLogicalDisk.DriveType & VbCrLf &_
  vbTab & "FileSystem: " &  objLogicalDisk.FileSystem & VbCrLf &_
  vbTab & "FreeSpace: " &  objLogicalDisk.FreeSpace & VbCrLf &_
  vbTab & "MediaType: " &  objLogicalDisk.MediaType & VbCrLf &_
  vbTab & "Name: " &  objLogicalDisk.Name & VbCrLf &_
  vbTab & "QuotasDisabled: " &  objLogicalDisk.QuotasDisabled & VbCrLf &_
  vbTab & "QuotasIncomplete: " &  objLogicalDisk.QuotasIncomplete _ 
    & VbCrLf &_
  vbTab & "QuotasRebuilding: " &  objLogicalDisk.QuotasRebuilding _
    & VbCrLf &_
  vbTab & "Size: " &  objLogicalDisk.Size & VbCrLf &_
  vbTab & "SupportsDiskQuotas: " & _
        objLogicalDisk.SupportsDiskQuotas & VbCrLf &_
  vbTab & "SupportsFileBasedCompression: " & _
        objLogicalDisk.SupportsFileBasedCompression & VbCrLf &_
  vbTab & "SystemName: " &  objLogicalDisk.SystemName & VbCrLf &_
  vbTab & "VolumeDirty: " &  objLogicalDisk.VolumeDirty & VbCrLf &_
  vbTab & "VolumeName: " &  objLogicalDisk.VolumeName & VbCrLf &_
  vbTab & "VolumeSerialNumber: " &  _
        objLogicalDisk.VolumeSerialNumber & VbCrLf & VbCrLf
Next

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\LogicalDisks.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\LogicalDisks.txt" )
'************************* ����� ***********************************
