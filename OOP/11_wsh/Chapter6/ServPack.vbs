'*******************************************************************
' ���: ServPack.vbs
' ����: VBScript
' ��������: ����� ������ ServicePack ��� ������������ �������
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer         ' ��� ����������
Dim strNamespace        ' ��� ������������ ����
Dim strClass            ' ��� ������ 
Dim objClass            ' ������ SWbemObject (����� WMI)
Dim colOperatingSystems ' ��������� ����������� ������ WMI
Dim objOperatingSystem  ' ������� ���������
Dim strResult           ' ������ ��� ������ �� �����

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"
strResult = "ServicePack ������������� �� ���� ���������� " & VbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_OperatingSystem
Set colOperatingSystems = objClass.Instances_

' ���������� �������� ��������� 
For Each objOperatingSystem in colOperatingSystems
  ' ��������� ������ ��� ������ �� �����
  strResult = strResult & "� " & _ 
              objOperatingSystem.ServicePackMajorVersion & "." &_
              objOperatingSystem.ServicePackMinorVersion & VbCrLf  
Next

' ������� ������������� ������ �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
