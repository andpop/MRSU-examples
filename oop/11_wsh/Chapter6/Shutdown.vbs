'*******************************************************************
' ���: Shutdown.vbs
' ����: VBScript
' ��������: ���������� ����������
'*******************************************************************
Option Explicit
On Error Resume Next
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colInstances      ' ��������� ����������� ������ WMI
Dim objInstance       ' ������� ���������
Dim iAnswer           ' ��� �������� ������� MsgBox

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:{(Shutdown,RemoteShutdown)}\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_OperatingSystem
Set colInstances = objClass.Instances_

' ���������� �������� ��������� 
For Each objInstance In colInstances
  ' ������� �� ����� ��������������
  iAnswer = MsgBox("��������� ��������� " & objInstance.CSNAME & " ?", _
                  vbQuestion + vbOKCancel, "��������!")

  If iAnswer = vbOK Then 
    ' ������� ��������� � ������������
    WScript.Echo "��������� " &  objInstance.CSNAME & " ����� ��������"  
    ' �������� ����� Shutdown
    objInstance.Shutdown()

    If Err.number <> 0 Then
      WScript.Echo  "����� ������: " & Err.Number & vbNewLine & _
                    "��������: " & Err.Description
    End If
  Else 
    ' ������� ��������� �� ������ ��������
    WScript.Echo  "�� ����� ���� ���������"
  End if
Next
'************************* ����� ***********************************
