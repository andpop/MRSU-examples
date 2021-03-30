'*******************************************************************
' ���: InfoAllTempFolders.vbs
' ����: VBScript
' ��������: ����� ������� ���� ����� Temp �� ����� �:
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim strResult         ' ��������� �������
Dim colFolders        ' ��������� ����������� ������ WMI
Dim objFolder         ' ������� ���������
Dim WshShell          ' ������ WshShell
Dim theNotepad        ' ������ WshScriptExec

' ��������� ���������
Const ForWriting = 2
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16

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
strResult = "�������� ���� ����� Windows �� ����� � : " & VbCrLf & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' ������� ��������� ����������� ������ Win32_Directory
Set colFolders = objService.ExecQuery(_
  "SELECT * FROM Win32_Directory WHERE Drive = 'C:' AND " &_ 
  "FileName = 'Temp' ",,_
  wbemFlagReturnImmediately + wbemFlagReturnImmediately)

' ���������� �������� ���������
For Each objFolder in colFolders
    ' ��������� ������ ��� ������ ����
  strResult = strResult &_
  "    Name: " & objFolder.Name & VbCrLf &_
  VbTab & "AccessMask: " & objFolder.AccessMask & VbCrLf &_
  VbTab & "Archive: " & objFolder.Archive & VbCrLf &_
  VbTab & "Caption: " & objFolder.Caption & VbCrLf &_
  VbTab & "Compressed: " & objFolder.Compressed & VbCrLf &_
  VbTab & "CompressionMethod: " & objFolder.CompressionMethod & VbCrLf &_
  VbTab & "CreationClassName: " & objFolder.CreationClassName & VbCrLf &_
  VbTab & "CreationDate: " & WMIDateStr(objFolder.CreationDate) & _
    VbCrLf &_
  VbTab & "CSCreationClassName: " & objFolder.CSCreationClassName & _
    VbCrLf &_
  VbTab & "CSName: " & objFolder.CSName & VbCrLf &_
  VbTab & "Description: " & objFolder.Description & VbCrLf &_
  VbTab & "Drive: " & objFolder.Drive & VbCrLf &_
  VbTab & "EightDotThreeFileName: " & objFolder.EightDotThreeFileName & _
    VbCrLf &_
  VbTab & "Encrypted: " & objFolder.Encrypted & VbCrLf &_
  VbTab & "EncryptionMethod: " & objFolder.EncryptionMethod & VbCrLf &_
  VbTab & "Extension: " & objFolder.Extension & VbCrLf &_
  VbTab & "FileName: " & objFolder.FileName & VbCrLf &_
  VbTab & "FileSize: " & objFolder.FileSize & VbCrLf &_
  VbTab & "FileType: " & objFolder.FileType & VbCrLf &_
  VbTab & "FSCreationClassName: " & objFolder.FSCreationClassName &_
    VbCrLf &_
  VbTab & "FSName: " & objFolder.FSName & VbCrLf &_
  VbTab & "Hidden: " & objFolder.Hidden & VbCrLf &_
  VbTab & "InstallDate: " & WMIDateStr(objFolder.InstallDate) & VbCrLf &_
  VbTab & "InUseCount: " & objFolder.InUseCount & VbCrLf &_
  VbTab & "LastAccessed: " & WMIDateStr(objFolder.LastAccessed) & _
    VbCrLf &_
  VbTab & "LastModified: " & WMIDateStr(objFolder.LastModified) & _
    VbCrLf &_
  VbTab & "Path: " & objFolder.Path & VbCrLf &_
  VbTab & "Readable: " & objFolder.Readable & VbCrLf &_
  VbTab & "Status: " & objFolder.Status & VbCrLf &_
  VbTab & "System: " & objFolder.System & VbCrLf &_
  VbTab & "Writeable: " & objFolder.Writeable & VbCrLf & VbCrLf
Next

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\PropAllFolder.txt"

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\PropAllFolder.txt" )
'************************* ����� ***********************************
