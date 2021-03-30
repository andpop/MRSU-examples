'*******************************************************************
' ���: SoftwareFeatures.vbs
' ����: VBScript
' ��������: ����� ������ ������������� ����������� ��������� 
'           �� ����� ������������ 
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colFeatures       ' ��������� ����������� ������ WMI
Dim objFeature        ' ������� ���������
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
strClass = "Win32_SoftwareFeature"
strResult = "����������  ������������� ����������� " &_
            " ���������:" & VbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_OperatingSystem
Set colFeatures = objClass.Instances_

' ���������� �������� ��������� 
For Each objFeature in colFeatures
 ' ��������� ������ ��� ������ �� �����
  strResult = strResult &_
    "Name: " & objFeature.Name & VbCrLf &_
    "Product Name: " & objFeature.ProductName & VbCrLf &_ 
    vbtab & "Accesses: " & objFeature.Accesses & VbCrLf &_
    vbtab & "Attributes: " & objFeature.Attributes & VbCrLf &_
    vbtab & "Caption: " & objFeature.Caption & VbCrLf &_
    vbtab & "Description: " & objFeature.Description & VbCrLf &_
    vbtab & "Identifying Number: " & objFeature.IdentifyingNumber _
    & VbCrLf &_
    vbtab & "Install Date: " & objFeature.InstallDate & VbCrLf &_
    vbtab & "Install State: " & objFeature.InstallState & VbCrLf &_
    vbtab & "Last Use: " & objFeature.LastUse & VbCrLf &_
    vbtab & "Name: " & objFeature.Name & VbCrLf &_
    vbtab & "Vendor: " & objFeature.Vendor & VbCrLf &_
    vbtab & "Version: " & objFeature.Version & VbCrLf & VbCrLf 
Next

' ������� ��������� � ���� � ������� ������� TextOut
TextOut  strResult, "C:\SoftwareFeatures.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\SoftwareFeatures.txt" )
'************************* ����� ***********************************
