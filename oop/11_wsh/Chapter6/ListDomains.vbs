'*******************************************************************
' ���: ListDomains.vbs                                              
' ����: VBScript                                                    
' ��������: ����� �� ����� ������ ���� ������� ��������� ����     
'*********************************************************************
Option Explicit

'��������� ����������
Dim objNameSpace        ' �������� ������ Namespace
Dim objDomain           ' ��������� ������� Domain
Dim strResult           ' ������ ��� ������ �� �����

'����������� � �������� �������� Namespace
Set objNameSpace = GetObject("WinNT:")
'������������� ������ ��� ��������� ��������-�������
objNameSpace.Filter = Array("domain")

strResult = "��� ��������� ������ � ����:" & vbCrLf & vbCrLf

' ���������� �������� ��������� 
For Each objDomain In objNameSpace
  '��������� ������ � ������� �������
  strResult = strResult & objDomain.Name & vbCrLf
Next

'����� ���������� �� �����
WScript.Echo strResult
'*************  ����� *********************************************
