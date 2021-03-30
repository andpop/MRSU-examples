'*******************************************************************
' ���: PnPDeviceInfo.vbs
' ����: VBScript
' ��������: ����� ������ ������������� PnP-��������� 
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemServices    
Dim colPnPEntities    ' ��������� ����������� ������ WMI
Dim objPnPEntity      ' ������� ���������
Dim strResult         ' �������������� ������
Dim WshShell          ' ������ WshShell
Dim theNotepad        ' ������ WshScriptExec

' ��������� ���������
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16
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
strResult = "������������������ PnP-���������� " & VbCrLf & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
' ������� ��������� ����������� ������ Win32_PnPEntity
Set colPnPEntities=objService.ExecQuery("SELECT * FROM Win32_PnPEntity"_
   ,,wbemFlagReturnImmediately+wbemFlagForwardOnly)

' ���������� �������� ��������� 
For Each objPnPEntity In colPnPEntities
  strResult = strResult & "Class GUID: " & _
              objPnPEntity.ClassGuid & VbCrLf
  strResult = strResult & "Description: " & _
              objPnPEntity.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objPnPEntity.DeviceID & VbCrLf
  strResult = strResult & "Manufacturer: " & _
              objPnPEntity.Manufacturer & VbCrLf
  strResult = strResult & "Name: " & _
              objPnPEntity.Name & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objPnPEntity.PNPDeviceID & VbCrLf
  strResult = strResult & "Service: " & _
              objPnPEntity.Service & VbCrLf
  strResult = strResult & "********************************" & VbCrLf & VbCrLf
Next

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\PnP.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\PnP.txt" )
'************************* ����� ***********************************
