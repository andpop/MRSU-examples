'*******************************************************************
' ���: MemoryInfo.vbs
' ����: VBScript
' ��������: ����� ���������� � ���������� ������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colPhysMemory     ' ��������� ����������� ������ WMI
Dim objPhysMemory     ' ������� ���������
Dim strResult         ' �������������� ������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_PhysicalMemory"
strResult = "���������� � ���������� ������:" & vbCrLf & vbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_PhysicalMemory
Set colPhysMemory = objClass.Instances_

' ���������� ���������
For Each objPhysMemory In colPhysMemory
  strResult = strResult & "Bank Label: " & _
              objPhysMemory.BankLabel & VbCrLf
  strResult = strResult & "Capacity: " & _
              objPhysMemory.Capacity & VbCrLf
  strResult = strResult & "Data Width: " & _
              objPhysMemory.DataWidth & VbCrLf
  strResult = strResult & "Description: " & _
              objPhysMemory.Description & VbCrLf
  strResult = strResult & "Device Locator: " & _
              objPhysMemory.DeviceLocator & VbCrLf
  strResult = strResult & "Form Factor: " & _
              objPhysMemory.FormFactor & VbCrLf
  strResult = strResult & "Hot Swappable: " & _
              objPhysMemory.HotSwappable & VbCrLf
  strResult = strResult & "Manufacturer: " & _
              objPhysMemory.Manufacturer & VbCrLf
  strResult = strResult & "Memory Type: " & _
              objPhysMemory.MemoryType & VbCrLf
  strResult = strResult & "Name: " & _
              objPhysMemory.Name & VbCrLf
  strResult = strResult & "Part Number: " & _
              objPhysMemory.PartNumber & VbCrLf
  strResult = strResult & "Speed: " & _
              objPhysMemory.Speed & VbCrLf
  strResult = strResult & "Tag: " & _
              objPhysMemory.Tag & VbCrLf
  strResult = strResult & "Type Detail: " & _
              objPhysMemory.TypeDetail & VbCrLf
Next

' ������� ��������� �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
