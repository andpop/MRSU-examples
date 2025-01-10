'*******************************************************************
' ���: MappingShare.vbs
' ����: VBScript
' ��������: ��������� ����������� ��� ����� ����������� ������� � 
'           �������� ����� �� �����
'*******************************************************************
Option Explicit

' ��������� ����������
Dim strComputer       ' ��� ����������
Dim strNamespace      ' ��� ������������ ����
Dim objService        ' ������ SWbemService
Dim colShares         ' ��������� ����������� ������ WMI 
Dim objShare          ' ������� ���������
Dim colAssociations   ' ��������� ����������� ������ WMI 
Dim objFolder         ' ������� ���������
Dim strResult         ' ��������� �������

'********************** ������ *************************************
' ����������� ��������� �������� ����������
strComputer = "."
strNamespace = "Root\CIMV2"
strResult = "����� ������ �������:" & VbCrLf

' ������������ � ������������ ���� WMI
Set objService = GetObject("WinMgmts:\\" &_
                                   strComputer & "\" & strNamespace)
' ������� ��������� ����������� ������ Win32_Share
Set colShares = objService.ExecQuery("SELECT * FROM Win32_Share")

' ���������� �������� ���������
For Each objShare in colShares
  ' ������� ��������� ����������� ������ Win32_ShareToDirectory
  Set colAssociations = objService.ExecQuery _
        ("ASSOCIATORS OF {Win32_Share.Name='" & objShare.Name & "'} " _
         & " WHERE AssocClass=Win32_ShareToDirectory")
  ' ���������� �������� ��������� 
  For Each objFolder In colAssociations
    ' ��������� ������ ��� ������ �� �����  
    strResult = strResult & "  " & objShare.Name & " - " &_
                objFolder.Name & VbCrLf
  Next
Next

' ������� ��������� �� �����
Wscript.Echo strResult
'************************* ����� ***********************************
