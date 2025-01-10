'*******************************************************************
' ���: ComputerRole.vbs
' ����: VBScript
' ��������: ����������� ���� ���������� � ������
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim strClass          ' ��� ������ 
Dim objClass          ' ������ SWbemObject (����� WMI)
Dim colInstances      ' ��������� ����������� ������ WMI
Dim objInstance       ' ������� ���������
Dim strComputerRole   ' ���� ���������� � ������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_ComputerSystem"

' �������� ��������� �� ����� WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' ������� ��������� ����������� ������ Win32_ComputerSystem
Set colInstances = objClass.Instances_

' ���������� �������� ��������� 
For Each objInstance In colInstances
    ' �������� �������� ���� ����������
    Select Case objInstance.DomainRole 
        Case 0 
            strComputerRole = "Standalone Workstation"
        Case 1        
            strComputerRole = "Member Workstation"
        Case 2
            strComputerRole = "Standalone Server"
        Case 3
            strComputerRole = "Member Server"
        Case 4
            strComputerRole = "Backup Domain Controller"
        Case 5
            strComputerRole = "Primary Domain Controller"
    End Select
    
    ' ������� ��������� �� �����
    Wscript.Echo "���� ���������� " & strComputer & ": " & strComputerRole
Next
'************************* ����� ***********************************
