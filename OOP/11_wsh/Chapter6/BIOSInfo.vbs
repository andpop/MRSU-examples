'*******************************************************************
' ���: BIOSInfo.vbs
' ����: VBScript
' ��������: ����� ���������� � BIOS
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colInstances      ' ��������� ����������� ������ WMI
Dim objBIOS           ' ������� ���������
Dim strResult         ' �������������� ������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_BIOS"
strResult = "���������� � BIOS :" & VbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("winmgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_BIOS
Set colInstances = objClass.Instances_

' ���������� �������� ��������� 
For Each objBIOS in colInstances
  strResult = strResult & "Name: " & objBIOS.Name & VbCrLf
  strResult = strResult & "Manufacturer: " & objBIOS.Manufacturer &_
     VbCrLf
  strResult = strResult & "Caption: " & objBIOS.Caption & VbCrLf
  strResult = strResult & "Description: " & objBIOS.Description & VbCrLf    
  strResult = strResult & "Build Number: " & objBIOS.BuildNumber & VbCrLf
  strResult = strResult & "Current Language: " & objBIOS.CurrentLanguage &_ 
  VbCrLf
  strResult = strResult & _
   "Installable Languages: " & objBIOS.InstallableLanguages & VbCrLf
  strResult = strResult & "Primary BIOS: " & objBIOS.PrimaryBIOS & VbCrLf
  strResult = strResult & "Release Date: " & objBIOS.ReleaseDate & VbCrLf
  strResult = strResult & "Serial Number: " & objBIOS.SerialNumber &_
    VbCrLf
  strResult = strResult & "SMBIOS Version: " & _
    objBIOS.SMBIOSBIOSVersion & VbCrLf
  strResult = strResult & _
    "SMBIOS Major Version: " & objBIOS.SMBIOSMajorVersion & VbCrLf
  strResult = strResult & _
    "SMBIOS Minor Version: " & objBIOS.SMBIOSMinorVersion & VbCrLf
  strResult = strResult & "SMBIOS Present: " & objBIOS.SMBIOSPresent _
    & VbCrLf
  strResult = strResult & "Status: " & objBIOS.Status & VbCrLf
  strResult = strResult & "Version: " & objBIOS.Version & VbCrLf
Next

'������� ������ �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
