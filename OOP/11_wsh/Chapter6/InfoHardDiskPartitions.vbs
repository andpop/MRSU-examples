'*******************************************************************
' ���: InfoHardDiskPartitions.vbs
' ����: VBScript
' ��������: ��������� ���������� � �������� �������� �����
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim strResult         ' ��������� �������
Dim colDiskPartitions ' ��������� ����������� ������ WMI
Dim objPartition      ' ������� ���������
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
strResult = "������� �������� �����: " & VbCrLf & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' ������� ��������� ����������� ������ Win32_DiskPartition
Set colDiskPartitions = objService.ExecQuery _
                       ("Select * from Win32_DiskPartition")

' ���������� �������� ���������
For each objPartition in colDiskPartitions
  ' ��������� ������ ��� ������ ����
  strResult = strResult &_
  vbTab & "Block Size: " & objPartition.BlockSize & VbCrLf &_
  vbTab & "Bootable: " & objPartition.Bootable & VbCrLf &_
  vbTab & "Boot Partition: " & objPartition.BootPartition & VbCrLf &_
  vbTab & "Description: " & objPartition.Description & VbCrLf &_
  vbTab & "Device ID: " & objPartition.DeviceID & VbCrLf &_
  vbTab & "Disk Index: " & objPartition.DiskIndex & VbCrLf &_
  vbTab & "Index: "  & objPartition.Index & VbCrLf &_
  vbTab & "Name: " & objPartition.Name & VbCrLf &_
  vbTab & "Number Of Blocks: " &_
           objPartition.NumberOfBlocks & VbCrLf &_
  vbTab & "Primary Partition: " &_
           objPartition.PrimaryPartition & VbCrLf &_
  vbTab & "Size: " & objPartition.Size & VbCrLf &_
  vbTab & "Starting Offset: " &_
           objPartition.StartingOffset & VbCrLf &_
  vbTab & "Type: " & objPartition.Type & VbCrLf & VbCrLf
Next

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\Partitions.txt"

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\Partitions.txt" )
'************************* ����� ***********************************
