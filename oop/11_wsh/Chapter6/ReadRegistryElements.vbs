'*******************************************************************
' ���: ReadRegistryElements.vbs
' ����: VBScript
' ��������: ������ �� ������� ���������� ��������� � ��������� DWORD  
'*******************************************************************
Option Explicit
 
' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strKeyPath        ' ��� ���������� �������
Dim strValueName      ' ��� ��������� �������
Dim strValue          ' �������� ���������� ��������� �������
Dim dwValue           ' �������� ��������� DWORD ������� 
Dim objReg            ' ������ SWbemObject ��� ������ � ��������

' ��������� ���������
const HKEY_LOCAL_MACHINE = &H80000002
'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."

' �������� ��������� �� ����� StdRegProv
Set objReg = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default:StdRegProv")
' ������ ��� ����������
strKeyPath = "SOFTWARE\Example key"
' ������ ��� ���������� ���������
strValueName = "Example String Value"
' ��������� ����� GetStringValue
objReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,strValue
' ������� �������� ��������� �������
WScript.Echo "�������� ��������� " & strKeyPath & "\" &_
             strValueName & ": " & strValue

' ������ ��� ��������� DWORD
strValueName = "Example DWORD Value"
' ��������� ����� GetDWORDValue
objReg.GetDWORDValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,dwValue
' ������� �������� ��������� �������
WScript.Echo "�������� ��������� " & strKeyPath & "\" &_
             strValueName & ": " & dwValue
'************************* ����� ***********************************
