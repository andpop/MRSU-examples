'*******************************************************************
' ���: OSProperty.vbs
' ����: VBScript
' ��������: ����� ������� ������������ �������
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer        ' ��� ����������
Dim strNamespace       ' ��� ������������ ����
Dim strClass           ' ��� ������ 
Dim objClass           ' ������ SWbemObject (����� WMI)
Dim colOperatingSystems' ��������� ����������� ������ WMI
Dim objOperatingSystem ' ������� ���������
Dim strResult          ' ������ ��� ������ �� �����

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"
strResult = " �������� ������������ �������: " & VbCrLf & VbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_OperatingSystem
Set colOperatingSystems = objClass.Instances_

' ���������� �������� ��������� 
For Each objOperatingSystem in colOperatingSystems
  ' �������� ������ ��� ������ �� ����� 
  strResult = strResult & "Boot Device: " & _ 
              objOperatingSystem.BootDevice & VbCrLf
  strResult = strResult & "Build Number: " & _
              objOperatingSystem.BuildNumber & VbCrLf 
  strResult = strResult & "Build Type: " & _
              objOperatingSystem.BuildType & VbCrLf
  strResult = strResult & "Caption: " & _
              objOperatingSystem.Caption & VbCrLf
  strResult = strResult & "Code Set: " & _
              objOperatingSystem.CodeSet & VbCrLf
  strResult = strResult & "Country Code: " & _
              objOperatingSystem.CountryCode & VbCrLf
  strResult = strResult & "Install Date: " & _
              objOperatingSystem.InstallDate & VbCrLf
  strResult = strResult & "Licensed Users: " & _
              objOperatingSystem.NumberOfLicensedUsers & VbCrLf
  strResult = strResult & "Organization: " & _
              objOperatingSystem.Organization & VbCrLf
  strResult = strResult & "OS Language: " & _
              objOperatingSystem.OSLanguage & VbCrLf
  strResult = strResult & "OS Product Suite: " & _
              objOperatingSystem.OSProductSuite & VbCrLf
  strResult = strResult & "OS Type: " & _
              objOperatingSystem.OSType & VbCrLf
  strResult = strResult & "Primary: " & _
              objOperatingSystem.Primary & VbCrLf
  strResult = strResult & "Registered User: " & _
              objOperatingSystem.RegisteredUser & VbCrLf
  strResult = strResult & "Serial Number: " & _
              objOperatingSystem.SerialNumber & VbCrLf
  strResult = strResult & "Version: " & _
              objOperatingSystem.Version & VbCrLf
Next

' ������� ��������� �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
