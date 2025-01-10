'*******************************************************************
' ���: CopyMP3File.vbs
' ����: VBScript
' ��������: ����������� ���� ������ � ����������� MP3 � ����� D:\MyMP3 
'*******************************************************************
Option Explicit
On Error Resume Next

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim colFiles          ' ��������� ����������� ������ WMI
Dim objFile           ' ������� ���������
Dim iError            ' ��������, ������������ �������
Dim objFSO            ' ������ FileSystemObject
Dim strFileName       ' ���������� ��� ���� � ����� ����������� �����
Dim strFolder         ' ��� ����� � ������� �������� �����
Dim strExt            ' ���������� ���������� ������

' ��������� ���������
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strFolder = "D:\MyMP3\"
strExt = "mp3"

' ������� ������ FileSystemObject
Set objFSO = CreateObject("Scripting.FileSystemObject")
' ������� �����
objFSO.CreateFolder(strFolder)

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)

' ������� ��������� ����������� ������ CIM_DataFile
Set colFiles = objService.ExecQuery(_
      "SELECT * FROM CIM_DataFile WHERE Drive = 'C:'" &_
      " AND Extension = '" & strExt & "'",,wbemFlagReturnImmediately _
                                  + wbemFlagReturnImmediately)
' ���������� �������� ���������
For Each objFile In colFiles
  ' ��������� ������ ��� �����������
  strFileName = strFolder & objFile.FileName & "." & objFile.Extension
  ' ��������� �� ��������� �� ����, � ����� � ������� �� ��������
  If LCase(objFile.Name) <> LCase(strFileName) Then
    ' �������� �����
    iError = objFile.Copy(strFileName)
    ' ��������� ������
    If iError <> 0 Then
      ' ������� ��������� �� ������ 
      WScript.Echo "������ ��� ����������� ����� " &_
                         objFile.FileName & "." & objFile.Extension
    End If
  End If
Next

WScript.Echo "����������� ���������."
'************************* ����� ***********************************
