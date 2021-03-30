'*******************************************************************
' ���: Keyboard.vbs
' ����: VBScript
' ��������: ����� ���������� � ����������
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colKeyboards      ' ��������� ����������� ������ WMI
Dim objKeyboard       ' ������� ���������
Dim strResult         ' �������������� ������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = " _Keyboard"
strResult = "���������� � ����������:" & vbCrLf & vbCrLf

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_Keyboard
Set colKeyboards = objClass.Instances_

' ���������� �������� ��������� 
For Each objKeyboard In colKeyboards
  strResult = strResult & "Caption: " & _
              objKeyboard.Caption & VbCrLf
  strResult = strResult & "Description: " & _
              objKeyboard.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objKeyboard.DeviceID & VbCrLf
  strResult = strResult & "Layout: " & _
              objKeyboard.Layout & VbCrLf
  strResult = strResult & "Name: " & _
              objKeyboard.Name & VbCrLf
  strResult = strResult & "Number of Function Keys: " & _
              objKeyboard.NumberOfFunctionKeys & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objKeyboard.PNPDeviceID 
Next

' ������� ��������� �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
