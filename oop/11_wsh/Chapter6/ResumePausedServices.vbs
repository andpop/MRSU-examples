'*******************************************************************
' ���: ResumePausedServices.vbs
' ����: VBScript
' ��������: ����������� ������ ���������������� ����� 
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objWMIService     ' ������ SWbemServices    
Dim colServices       ' ��������� ����������� ������ WMI
Dim objService        ' ������� ���������
Dim strResult         ' �������������� ������
Dim WshShell          ' ������ WshShell
Dim Res               

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"

' ������������ � ������������ ���� WMI
Set objWMIService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
' ��������� ��������� ������������� ����� 
Set colServices = objWMIService.ExecQuery _
("SELECT * FROM Win32_Service WHERE State = 'Paused' and StartMode = " _
 & "'Auto'")

' ������� ������ WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

' ������ �� ������ �����
Res = WshShell.Popup("����������� ������ ���� ���������������� �����?"_
  ,0, "������ �� �������� Windows",vbQuestion+vbYesNo)
If Res=vbYes Then
  ' ������������ ������ ���������������� ������         
  For Each objService In colServices
    objService.ResumeService()
  Next
  WScript.Echo "������ ���� ���������������� ����� ������������"
End If  
'************************* ����� ***********************************
