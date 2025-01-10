'*******************************************************************
' ���: MouseInfo.vbs
' ����: VBScript
' ��������: ����� ���������� � ���� 
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colMice           ' ��������� ����������� ������ WMI
Dim objMouse          ' ������� ���������
Dim strResult         ' �������������� ������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_PointingDevice"
strResult = "���������� � ����:" & vbCrLf & vbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_PointingDevice
Set colMice = objClass.Instances_

' ���������� �������� ��������� 
For Each objMouse In colMice
  strResult = strResult & "Hardware Type: " & _
              objMouse.HardwareType & VbCrLf
  strResult = strResult & "Number of Buttons: " & _
              objMouse.NumberOfButtons & VbCrLf
  strResult = strResult & "Status: " & objMouse.Status & VbCrLf
  strResult = strResult & "PNP Device ID: " & objMouse.PNPDeviceID
Next

' ������� ��������� �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
