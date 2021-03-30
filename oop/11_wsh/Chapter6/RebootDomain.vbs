'*******************************************************************
' ���: RebootDomain.vbs
' ����: VBScript
' ��������: ������������ ���� ����������� �� ������ Windows NT
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strOurComputer    ' ��� ����������, � �������� ������� ��������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colInstances      ' ��������� ����������� ������ WMI
Dim objInstance       ' ������� ���������
Dim objDictionary     ' ������ Dictionary 
Dim objItem           ' ������� ������� Dictionary

' ��������� ��� ���������� ������� Dictionary
Sub FillComputerDictionary()
' ��������� ����������
Dim strDomain, objDomain, objComputer, i
  ' ������� ������ Dictionary
  Set objDictionary = CreateObject("Scripting.Dictionary")
  '������ ��� ������
  strDomain = "WinNT://SBRM"
  '����������� � �������� Domain
  Set objDomain = GetObject(strDomain)
  '������������� ������ ��� ��������� ��������-�����������
  objDomain.Filter = Array("computer")
  
  i = 0
  ' ���� ��� ������ ����� �� �����
  For Each objComputer In objDomain
    ' ��������� ������� � ������ Dictionary
    objDictionary.Add i, objComputer.Name
    i = i + 1
  Next

End Sub

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"

' �������� ��������� �� ����� WMI ��� ���������� ���������
Set objClass = GetObject("WinMgmts:{(Shutdown,RemoteShutdown)}\\.\" &_ 
               strNamespace & ":" & strClass)
' ���������� ��� ���������� ����������
strOurComputer = objClass.CSName

' ��������� ������ Dictionary ���������� �� ����� C:\ComputerList.txt
FillComputerDictionary()

' ���������� � ����� ��� �������� ������� Dictionary
For Each objItem In objDictionary
  ' �������� ��� ���������� �� �������� �������� ������� Dictionary
  strComputer = objDictionary.Item(objItem)
  ' �������� ��������� �� ����� WMI
  Set objClass = GetObject("WinMgmts:{(Shutdown,RemoteShutdown)}\\" &_ 
                 strComputer & "\" & strNamespace & ":" & strClass)
  ' ���������, �� ��������� �� strComputer � ������ ���������� 
  ' ���������� 
  If strOurComputer <> strComputer Then
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
  '************************* ����� ***********************************
