'*******************************************************************
' ���: Classes.vbs
' ����: VBScript
' ��������: �������� ���� ������� � ������������ ����
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer        ' ��� ����������
Dim strResult          ' ��������� (��������� ���������) 
Dim strNamespace       ' ��� ������������ ����
Dim WshShell           ' ������ WshShell
Dim objService         ' ������ SWbemServices
Dim colClasses         ' ��������� �������
Dim objClass           ' ������� ���������
Dim theNotepad         ' ������ WshScriptExec

' ��������� ��� ������� ������ �������� �����
Const ForWriting = 2

' ������� ��� ������ ���������� � ���� 
Sub TextOut (Text, File)
  ' ��������� ����������
  Dim  FSO, FOut 
  ' ������� ������ FileSystemObject
  Set  FSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' ��������� �������� ���� ��� ������
  Set  FOut = FSO.OpenTextFile (File,ForWriting,true)
  ' ���������� ��������� ������ � ����
  FOut.WriteLine Text
  ' ��������� �������� ����
  FOut.Close
End Sub

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strResult = "" 
strNamespace = "Root\CIMV2"

' ������������ � ������������ ���� WMI
Set objService = GetObject("winmgmts:\\" & strComputer & "\" & strNamespace)

' ������� ��������� ������� WMI
Set colClasses = objService.SubclassesOf()

' ���������� �������� ��������� 
For Each objClass In colClasses
    '��������� �������������� ������    
    strResult=strResult & "  " & objClass.Path_.Class & VbCrLf 
Next

' ������� ��������� � ���� � ������� ������� TextOut
TextOut " ������ ������� � ������������ ����  " & strNamespace &_
        " : " & VbCrLf & strResult, "C:\Classes.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\Classes.txt" )
'************************* ����� ***********************************
