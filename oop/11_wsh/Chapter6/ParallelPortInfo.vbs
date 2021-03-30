'*******************************************************************
' ���: ParallelPortInfo.vbs
' ����: VBScript
' ��������: ����� ���������� � ������������ ������ 
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colPorts          ' ��������� ����������� ������ WMI
Dim objPort           ' ������� ���������
Dim strCapability     ' �������������� ������ �����
Dim strResult         ' �������������� ������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_ParallelPort"
strResult = "���������� � ������������ ������:" & vbCrLf & vbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_ParallelPort
Set colPorts = objClass.Instances_

' ���������� �������� ��������� 
For Each objPort In colPorts
  strResult = strResult & "Availability: " & _
              objPort.Availability & VbCrLf
  For Each strCapability In objPort.Capabilities
    strResult = strResult & "Capability: " & _
                strCapability & VbCrLf
  Next
  strResult = strResult & "Description: " & _
              objPort.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objPort.DeviceID & VbCrLf
  strResult = strResult & "Name: " & _
              objPort.Name & VbCrLf
  strResult = strResult & "OS Auto Discovered: " & _
              objPort.OSAutoDiscovered & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objPort.PNPDeviceID & VbCrLf
  strResult = strResult & "Protocol Supported: " & _
              objPort.ProtocolSupported & VbCrLf
Next

' ������� ��������� �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
