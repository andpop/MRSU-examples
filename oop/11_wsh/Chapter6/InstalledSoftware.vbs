'*******************************************************************
' ���: InstalledSoftware.vbs
' ����: VBScript
' ��������: ����� ������ ������������� ����������� ��������� 
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colSoftware       ' ��������� ����������� ������ WMI
Dim objSoftware       ' ������� ���������
Dim strResult         ' �������������� ������
Dim WshShell          ' ������ WshShell
Dim theNotepad        ' ������ WshScriptExec

' ��������� ��� ������� ������ �������� �����
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
strClass = "Win32_Product"
strResult = "������ ������������� ����������� ���������:  " & VbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_Product
Set colSoftware = objClass.Instances_

' ���������� �������� ��������� 
For Each objSoftware in colSoftware
  ' ��������� ������ ��� ������ �� �����
  strResult = strResult &_
    " Name: " & objSoftware.Name & VbCrLf & _
    vbTab & "Caption: " & objSoftware.Caption & VbCrLf & _
    vbTab & "Description: " & objSoftware.Description & VbCrLf & _
    vbTab & "IdentifyingNumber: " & objSoftware.IdentifyingNumber & _
    VbCrLf & _
    vbTab & "InstallLocation: " & objSoftware.InstallLocation & VbCrLf _
    & vbTab & "InstallState: " & objSoftware.InstallState & VbCrLf & _    
    vbTab & "PackageCache: " & objSoftware.PackageCache & VbCrLf & _
    vbTab & "SKUNumber: " & objSoftware.SKUNumber & VbCrLf & _    
    vbTab & "Vendor: " & objSoftware.Vendor & VbCrLf & _
    vbTab & "Version: " & objSoftware.Version & VbCrLf & VbCrLf
Next

' ������� ��������� � ���� � ������� ������� TextOut
TextOut  strResult, "C:\InstalledSoftware.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\InstalledSoftware.txt" )
'************************* ����� ***********************************
