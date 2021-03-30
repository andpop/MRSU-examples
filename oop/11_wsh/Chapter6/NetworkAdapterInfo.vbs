'*******************************************************************
' ���: NetworkAdapterInfo.vbs
' ����: VBScript
' ��������: ����� ���������� � ������� ���������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer         ' ��� ����������
Dim strNamespace        ' ��� ������������ ����
Dim objService          ' ������ SWbemServices    
Dim colNetworkAdapters  ' ��������� ����������� ������ WMI
Dim objNetworkAdapter   ' ������� ���������
Dim strResult           ' �������������� ������
Dim WshShell            ' ������ WshShell
Dim theNotepad          ' ������ WshScriptExec

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
strResult = "������������������ ������� �������� " & VbCrLf & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)

Set colNetworkAdapters = objService.ExecQuery(_
                         "SELECT * FROM Win32_NetworkAdapter",,_
                         wbemFlagReturnImmediately+wbemFlagForwardOnly)

' ���������� �������� ��������� 
For Each objNetworkAdapter In colNetworkAdapters
  strResult = strResult & "Adapter Type: " & _
    objNetworkAdapter.AdapterType & VbCrLf &_
    "Description: " & objNetworkAdapter.Description & vbCrLf &_
    "Installed: " & objNetworkAdapter.Installed & vbCrLf &_
    "Manufacturer: " & objNetworkAdapter.Manufacturer & vbCrLf &_
    "Product Name: " & objNetworkAdapter.ProductName & vbCrLf &_
    "Net Connection ID: " & objNetworkAdapter.NetConnectionID & vbCrLf &_
    "Net Connection Status: " & _
      objNetworkAdapter.NetConnectionStatus & vbCrLf _
    "MAC Address: " & objNetworkAdapter.MACAddress & vbCrLf &_  
    "PNP Device ID" & objNetworkAdapter.PNPDeviceID
Next

' ������� ��������� � ��������� ����
TextOut  strResult, "C:\NetworkAdapters.txt" 

'������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'��������� ��������� ���� � ��������
Set theNotepad = WshShell.Exec("notepad " & "C:\NetworkAdapters.txt" )
'************************* ����� ***********************************
