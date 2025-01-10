'*******************************************************************
' ���: RebootTextFile.vbs
' ����: VBScript
' ��������: ������������ ���� �����������, ��������� � ��������� �����
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colInstances      ' ��������� ����������� ������ WMI
Dim objInstance       ' ������� ���������
Dim objDictionary     ' ������ Dictionary 
Dim objItem           ' ������� ������� Dictionary
' ��������� ��� ������� ������ �������� �����
Const ForReading = 1

' ��������� ��� ���������� ������� Dictionary
Sub FillComputerDictionary(File)
' ��������� ����������
Dim objFSO, objTextFile,i,s
  ' ������� ������ Dictionary
  Set objDictionary = CreateObject("Scripting.Dictionary")
  ' ������� ������ FileSystemObject
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  ' ��������� ���� ��� ������
  Set objTextFile = objFSO.OpenTextFile(File, ForReading)
  i = 0
  ' ���� ��� ������ ����� �� �����
  Do Until objTextFile.AtEndOfStream
    ' ������ ������ �� �����
    s = objTextFile.Readline
    ' ��������� ������� � ������ Dictionary
    objDictionary.Add i, s
    i = i + 1
  Loop

End Sub

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"

' ��������� ������ Dictionary ���������� �� ����� C:\ComputerList.txt
FillComputerDictionary("C:\ComputerList.txt")

' ���������� � ����� ��� �������� ������� Dictionary
For Each objItem in objDictionary
  ' �������� ��� ���������� �� �������� �������� ������� Dictionary
  strComputer = objDictionary.Item(objItem)
  ' �������� ��������� �� ����� WMI
  Set objClass = GetObject("WinMgmts:{(Shutdown,RemoteShutdown)}\\" &_ 
                 strComputer & "\" & strNamespace & ":" & strClass)
  ' ������� ��������� ����������� ������ Win32_OperatingSystem
  Set colInstances = objClass.Instances_

  ' ���������� �������� ��������� 
  For Each objInstance In colInstances
    ' ������� �� ����� ��������������
    WScript.Echo "��������� " &  objInstance.CSNAME &_
                 " ����� ������������ "  
    ' ��� ������� ���������� �������� ����� Reboot
    objInstance.Reboot()
  Next
  
Next  
'************************* ����� ***********************************
