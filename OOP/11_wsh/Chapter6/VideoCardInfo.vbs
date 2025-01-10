'*******************************************************************
' ���: VideoCardInfo.vbs
' ����: VBScript
' ��������: ����� ���������� � ����������
'*******************************************************************
Option Explicit

Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colVideoCont      ' ��������� ����������� ������ WMI
Dim objVideoCont      ' ������� ���������
Dim strResult         ' �������������� ������
Dim WshShell          ' ������ WshShell
Dim theNotepad        ' ������ WshScriptExec

' ��������� ���������
Const ForWriting = 2

' ��������� ��� ������ ���������� � ���� 
Sub TextOut (Text, File)
  ' ��������� ����������
  Dim  objFSO, FOut 
  ' ������� ������ FileSystemObject
  Set  objFSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' ��������� �������� ���� ��� ������
  Set  FOut = objFSO.OpenTextFile (File,ForWriting,true)
  ' ���������� ��������� ������ � ����
  FOut.WriteLine Text
  ' ��������� �������� ����
  FOut.Close
End Sub

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_VideoController"
strResult = "���������� � ����������:" & vbCrLf & vbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_VideoController
Set colVideoCont = objClass.Instances_

' ���������� �������� ��������� 
For Each objVideoCont In colVideoCont
  strResult = strResult & "Adapter Compatibility: " & _
              objVideoCont.AdapterCompatibility & VbCrLf
  strResult = strResult & "Adapter DAC Type: " & _
              objVideoCont.AdapterDACType & VbCrLf
  strResult = strResult & "Adapter RAM: " & _
              objVideoCont.AdapterRAM & VbCrLf
  strResult = strResult & "Color Table Entries: " & _
              objVideoCont.ColorTableEntries & VbCrLf
  strResult = strResult & "Current Bits Per Pixel: " & _
              objVideoCont.CurrentBitsPerPixel & VbCrLf
  strResult = strResult & "Current Horizontal Resolution: " & _
              objVideoCont.CurrentHorizontalResolution & VbCrLf
  strResult = strResult & "Current Number Of Colors: " & _
              objVideoCont.CurrentNumberOfColors & VbCrLf
  strResult = strResult & "Current Refresh Rate: " & _
              objVideoCont.CurrentRefreshRate & VbCrLf
  strResult = strResult & "Current Refresh Rate: " & _
              objVideoCont.CurrentRefreshRate & VbCrLf
  strResult = strResult & "Current Vertical Resolution: " & _
              objVideoCont.CurrentVerticalResolution & VbCrLf
  strResult = strResult & "Description: " & _
              objVideoCont.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objVideoCont.DeviceID & VbCrLf
  strResult = strResult & "Device Specific Pens: " & _
              objVideoCont.DeviceSpecificPens & VbCrLf
  strResult = strResult & "Driver Date: " & _
              objVideoCont.DriverDate & VbCrLf
  strResult = strResult & "Driver Version: " & _
              objVideoCont.DriverVersion & VbCrLf
  strResult = strResult & "INF Filename: " & _
              objVideoCont.InfFilename & VbCrLf
  strResult = strResult & "INF Section: " & _
              objVideoCont.InfSection & VbCrLf
  strResult = strResult & "Installed Display Drivers: " & _
              objVideoCont.InstalledDisplayDrivers & VbCrLf
  strResult = strResult & "Name: " & _
              objVideoCont.Name & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objVideoCont.PNPDeviceID & VbCrLf
  strResult = strResult & "Specification Version: " & _
              objVideoCont.SpecificationVersion & VbCrLf
  strResult = strResult & "Video Architecture: " & _
              objVideoCont.VideoArchitecture & VbCrLf
  strResult = strResult & "Video Memory Type: " & _
              objVideoCont.VideoMemoryType & VbCrLf
  strResult = strResult & "Video Mode Description: " & _
              objVideoCont.VideoModeDescription & VbCrLf
Next

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\video.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\video.txt" )
'************************* ����� ***********************************
