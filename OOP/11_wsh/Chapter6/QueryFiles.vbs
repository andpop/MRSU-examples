'*******************************************************************
' ���: QueryFiles.vbs
' ����: VBScript
' ��������: ����� ������ ������ �� ����� C: � ����������� doc
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim strResult         ' ��������� �������
Dim colFiles          ' ��������� ����������� ������ WMI
Dim objFile           ' ������� ���������
Dim WshShell          ' ������ WshShell
Dim theNotepad        ' ������ WshScriptExec

' ��������� ���������
Const ForWriting = 2
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16

' ������� ��� ������ ���������� � ����
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
strResult = "��� ����� �� ����� �: � ����������� doc: " & VbCrLf & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' ������� ��������� ����������� ������ CIM_DataFile
Set colFiles = objService.ExecQuery(_
  "SELECT * FROM CIM_DataFile WHERE Drive = 'C:' AND " &_
  "Extension = 'doc' AND Name LIKE '%win%'",,_
   wbemFlagReturnImmediately + wbemFlagReturnImmediately)

' ���������� �������� ���������
For Each objFile in colFiles
    ' ��������� ������ ��� ������ ����
    strResult = strResult & objFile.Name & "   Size: " &_
                objFile.FileSize & " ����" & VbCrLf
Next

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\Files.txt"

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\Files.txt" )
'************************* ����� ***********************************
