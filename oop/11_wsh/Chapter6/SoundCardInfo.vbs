'*******************************************************************
' ���: SoundCardInfo.vbs
' ����: VBScript
' ��������: ����� ���������� � �������� �����
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colSoundCards     ' ��������� ����������� ������ WMI
Dim objSoundCard      ' ������� ���������
Dim strResult         ' �������������� ������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_SoundDevice"
strResult = "���������� � �������� �����:" & vbCrLf & vbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_SoundDevice
Set colSoundCards = objClass.Instances_

' ���������� �������� ��������� 
For Each objSoundCard in colSoundCards
  strResult = strResult & "Description: " & _
              objSoundCard.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objSoundCard.DeviceID & VbCrLf
  strResult = strResult & "DMA Buffer Size: " & _
              objSoundCard.DMABufferSize & VbCrLf
  strResult = strResult & "Manufacturer: " & _
              objSoundCard.Manufacturer & VbCrLf
  strResult = strResult & "MPU 401 Address: " & _
              objSoundCard.MPU401Address & VbCrLf
  strResult = strResult & "Name: " & _
              objSoundCard.Name & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objSoundCard.PNPDeviceID & VbCrLf
  strResult = strResult & "Product Name: " & _
              objSoundCard.ProductName & VbCrLf
  strResult = strResult & "Status Information: " & _
              objSoundCard.StatusInfo & VbCrLf
Next

' ������� ��������� �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
