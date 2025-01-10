'*******************************************************************
' ���: Sample_WMI_Tool.vbs
' ����: VBScript
' ��������: WMI-������� ��� ����������������� ������� �������
'*******************************************************************
Option Explicit

' ��������� ���������� ����������
Dim WshShell         ' ������ WshShell
Dim objIE            ' ������ InternetExplorer.Application
Dim objDocument      ' ������ Document
Dim strPathHTML      ' ���� � HTML-�����
Dim objLocator       ' ������ SWbemLocator
Dim objService       ' ������ SWbemService
Dim objSink          ' ������ SWbemSink
Dim bIsQuit          ' ����������-���� ������ �� �����

'-----------------------------------------------------------------
' ����������� HTML-����� �� ������
Sub ShowForm
  ' �������� ������ �� ������ Document
  Set objDocument = objIE.Document
  ' ��������� ������ �������
  SeekDomains
  ' ��������� ������ �����������
  SeekComputers
  ' ������ ���� Internet Explorer �������
  objIE.Visible = true
  ' ��������� ������ "����������"
  objDocument.all.btnConnect.Disabled = False
  ' ������ ������������ �������� ���������� � �����
  objDocument.all.btnExecuteAction.Disabled = True
  objDocument.all.btnTerminate.Disabled = True
  objDocument.all.cbUserProc.Disabled = True
  objDocument.all.txtCurrUser.Disabled = True
  objDocument.all.txtIP.Disabled = True
  objDocument.all.txtMAC.Disabled = True
  
  ' ���������� ���������-����������� ������� ��������� ���������� � �����
  Set objDocument.all.selDomain.onChange = GetRef("SeekComputers")
  Set objDocument.all.btnConnect.onClick = GetRef("Connect")
  Set objDocument.all.btnExecuteAction.onClick = GetRef("ExecuteAction")
  Set objDocument.all.cbUserProc.onClick = GetRef("RefreshProcessList")
  Set objDocument.all.btnTerminate.onClick = GetRef("Terminate")
End Sub 

'-----------------------------------------------------------------
' ������������ � ����� ������ ��������� �������
Sub SeekDomains
  ' ��������� ����������
  Dim objNamespace, objDomain, strHTML
  
  ' ����������� � �������� �������� Namespace
  Set objNamespace = GetObject("WinNT:")
  ' ������������� ������ ��� ��������� ��������-�������
  objNamespace.Filter = Array("domain")
  ' ��������� HTML-��� ��������������� ������ �������
  strHTML = "<SELECT STYLE='WIDTH: 150px' NAME='selDomain'>"
  strHTML = strHTML & "<OPTION VALUE=''></OPTION>"
  ' ���������� � ����� ��� ��������� ������
  For Each objDomain In objNamespace
    ' ��������� HTML-������ � ������ ������
    strHTML = strHTML & "<OPTION VALUE=" &"'" & objDomain.Name & "' >"
    strHTML = strHTML & objDomain.Name & "</OPTION>"
  Next
  ' ��������� HTML-��� � ��������
  objDocument.all.optDomain.InnerHTML=strHTML
End Sub

'-----------------------------------------------------------------
' ������������ � ����� ������ ����������� � ������
Sub SeekComputers
  ' ��������� ����������
  Dim strHTML, strDomain, objDomain, objComp
  
  strHTML = "<SELECT STYLE='WIDTH: 150px' NAME='selStation'>"
  If objDocument.all.selDomain.Value<>"" Then '������ ������������ �����
    ' ��������� ��� ������
    strDomain = objDocument.all.selDomain.Value
    ' ����������� � �������� Domain
    Set objDomain = GetObject("WinNT://" & strDomain)
    ' ���������� ��� ������� ������
    For Each objComp In objDomain
      If objComp.Class = "Computer" Then
        ' ��������� HTML-������ � ������ ����������
        strHTML = strHTML & "<OPTION VALUE='" & objComp.Name & "'>" &_
                  objComp.Name & "</OPTION>"
      End If
    Next 
    strHTML = strHTML & "</SELECT>"
  Else
    ' ������ ������ ����� - �������� � ��������� �������
    strHTML = strHTML & "<OPTION VALUE='.'>.</OPTION>"
  End If  
  ' ��������� �������������� HTML-��� � ��������  
  objDocument.all.optStation.InnerHTML = strHTML
End Sub

'-----------------------------------------------------------------
' ����������� � ������ WMI
Sub Connect
  ' ��������� ����������
  Dim strComputer, strUser, strIP, strMAC, strPassword, intRes
  
  On Error Resume Next
  ' ��������� ����� ����������, ������������ � ������
  strComputer = objDocument.all.selStation.Value
  strUser = objDocument.all.txtUser.Value
  strPassword = objDocument.all.txtPassword.Value
  
  ' ������� ������ SWbemLocator
  Set objLocator = CreateObject("WbemScripting.SWbemLocator")
  If strComputer="." Then
    ' ����������� �� ������� WMI �� ��������� ����������
    Set objService = objLocator.ConnectServer(".", "Root\CIMV2")
  Else  
    ' ����������� �� ������� WMI �� ��������� ����������
    Set objService = objLocator.ConnectServer(strComputer,"Root\CIMV2",_
                      strUser,strPassword)
  End If
  
  ' ������������ ������
  If Err.Number <> 0 Then  ' ��������� ������ ��� ����������� � WMI
    ' ������� ��������� �� ������
    intRes = MsgBox ("������ ��� ���������� � WMI # " &_
      CStr(Err.Number) & " " & Err.Description,_
           vbOkOnly+vbInformation,"������") 
    ' ������� �������� ������� Err
    Err.Clear
  Else
    ' ������� ������ ���������
    ShowProcesses("All")
    ' ������������� �� ��������� � �������� WMI
    SubscribeEvents
    ' ���������� ��� ��������� ������������
    objDocument.all.txtCurrUser.Value = GetCurrentUserName
    ' ���������� MAC- � IP-������ �������� ��������
    GetNetworkAdapterInfo strIP, strMAC
    objDocument.all.txtIP.Value = strIP
    objDocument.all.txtMAC.Value = strMAC
    
    ' ������ ���������� �������� ���������� � �����
    objDocument.all.btnExecuteAction.Disabled = False
    objDocument.all.btnTerminate.Disabled = False
    objDocument.all.btnTerminate.Disabled = False
    objDocument.all.cbUserProc.Disabled = False
  End If  
End Sub

'-----------------------------------------------------------------
' ��������� ����� ��������� ������������
Function GetCurrentUserName
  ' ��������� ����������
  Dim ColUserName, objUserName
  
  ' ������� ��������� ����������� ������ Win32_ComputerSystem
  Set ColUserName = objService.ExecQuery _
    ("SELECT * FROM Win32_ComputerSystem")
  ' ���������� ���������
  For Each objUserName In ColUserName
    ' ���������� ��� ��������� ������������
    GetCurrentUserName = objUserName.UserName
  Next 
End Function

'-----------------------------------------------------------------
' ��������� IP- � MAC-������� �������� ��������
Function GetNetworkAdapterInfo(ByRef strIP, ByRef strMac)
  ' ��������� ����������
  Dim colNetworkAdapters, objNetworkAdapter, colPnPDevices
  Dim objPnpDevice, colDeviceBuses, objDeviceBus
  Dim colNetworkAdapterSettings, objNetworkAdapterSetting
  
  ' ������� ��������� ����������� ������ Win32_NetworkAdapter
  Set colNetworkAdapters = objService.ExecQuery(_
                       "SELECT * FROM Win32_NetworkAdapter")    
  ' ���������� �������� ���������
  For Each objNetworkAdapter In colNetworkAdapters
    ' ������� ��������� ����������� ������ Win32_PnPDevice
    Set colPnPDevices = objService.ExecQuery _
        ("ASSOCIATORS OF {Win32_NetworkAdapter.DeviceID='" & _
         objNetworkAdapter.DeviceID & "'} " &_
         " WHERE AssocClass=Win32_PnPDevice")
    ' ���������� �������� ��������� 
    For Each objPnpDevice In colPnPDevices
      ' ������� ��������� ��������������� ����������� 
      ' ������ Win32_DeviceBus
      Set colDeviceBuses = objService.ExecQuery _
        ("ASSOCIATORS OF {Win32_PnPEntity.DeviceID='" & _ 
         objPnpDevice.DeviceID & "'} " &_
         " WHERE AssocClass=Win32_DeviceBus")
      ' ���������� �������� ���������  
      For Each objDeviceBus In colDeviceBuses
        ' ���������� MAC-����� �������� �������� 
        strMac = objNetworkAdapter.MACAddress
        ' ������� ��������� ��������������� ����������� ������ 
        ' Win32_NetworkAdapter
        Set colNetworkAdapterSettings = objService.ExecQuery _
          ("ASSOCIATORS OF {Win32_NetworkAdapter.DeviceID='" & _
          objNetworkAdapter.DeviceID & "'} " &_
          " WHERE AssocClass = Win32_NetworkAdapterSetting")
        ' ���������� �������� �������������� ��������� 
        For Each objNetworkAdapterSetting In colNetworkAdapterSettings
           strIP = objNetworkAdapterSetting.IPAddress(0)
        Next
      Next
    Next
  Next 
End Function

'-----------------------------------------------------------------
' ���������� ������ ������������
Sub Logoff
  ' ��������� ����������
  Dim strQuery, colOS, objOS
  
  strQuery = "SELECT * FROM Win32_OperatingSystem"
  Set colOS = objService.ExecQuery(strQuery)
  For Each objOS In colOS
    objOS.Win32Shutdown(0)
  Next
End Sub

'-----------------------------------------------------------------
' ������������ ����������
Sub Reboot
  ' ��������� ����������
  Dim strQuery, colOS, objOS
  
  strQuery = "SELECT * FROM Win32_OperatingSystem"
  Set colOS = objService.ExecQuery(strQuery)
  For Each objOS In colOS
    objOS.Reboot
  Next
End Sub

'-----------------------------------------------------------------
' ���������� ����������
Sub Shutdown
  ' ��������� ����������
  Dim strQuery, colOS, objOS
  
  strQuery = "SELECT * FROM Win32_OperatingSystem"
  Set colOS = objService.ExecQuery(strQuery)
  For Each objOS In colOS
    objOS.Shutdown
  Next
End Sub

'-----------------------------------------------------------------
' ����� � ���������� ������� ��������
Sub ExecuteAction
Dim intRes
  If objDocument.all.rbAction("LogoffUser").checked Then
    ' ��������� ����� ������ ��������� ������������
    intRes = MsgBox ("��������� ����� ������������ " &_
             objDocument.all.txtCurrUser.Value & "?",_
             vbYesNo+vbQuestion,"��������")
    If intRes = vbYes Then
      Logoff
    End If
  ElseIf objDocument.all.rbAction("Restart").checked Then
    ' ������������� ���������
    intRes = MsgBox ("������������� ��������� " &_
             objDocument.all.selStation.Value &_
             "?",vbYesNo+vbQuestion,"��������")
    If intRes = vbYes Then
      Reboot
    End If
  ElseIf objDocument.all.rbAction("Shutdown").checked Then
    ' ��������� ���������
    intRes = MsgBox ("��������� ��������� " &_
             objDocument.all.selStation.Value &_
             "?",vbYesNo+vbQuestion,"��������")
    If intRes = vbYes Then
      Shutdown
    End If
  End If  
End Sub

'-----------------------------------------------------------------
' ������������ � ����� ������ ���������� ���������
Sub ShowProcesses(strMode)
  ' ��������� ����������
  Dim strHTML, colProcesses, objProcess, intRes
  Dim strUserDomain,strUserName,strFullUserName
  
  strHTML = "<SELECT SINGLE STYLE='WIDTH: 280px' NAME='selProcess'� SIZE=10>"
  ' ������� ��������� ����������� ������ Win32_Process
  Set colProcesses = objService.ExecQuery("SELECT * FROM Win32_Process")
  ' ���������� �������� ��������� ���������
  For Each objProcess In colProcesses
    ' ���������� ��������� ��������
    intRes = objProcess.GetOwner(strUserName,strUserDomain)
    strFullUserName = strUserDomain & "\" & strUserName
    If strMode="All" Then
      ' ������� ��� ��������
      strHTML = strHTML & "<OPTION VALUE='" & objProcess.Name & "'>"
      strHTML = strHTML & objProcess.Name & "</OPTION>"
    Else
      ' ������� ������ �������� ������������
      If strFullUserName=objDocument.all.txtCurrUser.Value Then
        strHTML = strHTML & "<OPTION VALUE='" & objProcess.Name & "'>"
        strHTML = strHTML & objProcess.Name & "</OPTION>"
      End If
    End If
  Next
  strHTML = strHTML & "</SELECT>"
  ' ���������� HTML-������ � ��������
  objDocument.all.optProcess.InnerHTML=strHTML
End Sub

'-----------------------------------------------------------------
' ���������� ������ ���������
Sub RefreshProcessList
  If objDocument.all.cbUserProc.Checked Then
    ' ������� ������ �������� ������������
    ShowProcesses("User")
  Else
    ' ������� ��� ��������
    ShowProcesses("All")
  End If
End Sub

'-----------------------------------------------------------------
' ���������� ������ ��������
Sub Terminate
  ' ��������� ����������
  Dim strProcess, strQuery, colProcesses, objProcess, intRes
  
  '��������� ��� ����������� �������� �� ������
  strProcess = objDocument.all.selProcess.Value
  ' ������� ������ �� ���������� ��������
  intRes = MsgBox ("��������� ������� " & strProcess & "?",_
    vbYesNo+vbQuestion,"��������")
  If intRes = vbYes Then
    strQuery = "SELECT * FROM Win32_Process WHERE Name='" &_
                strProcess & "'"
    ' ��������� ��������� ��������� � ������ strProcess
    Set colProcesses = objService.ExecQuery(strQuery)
    ' ���������� ��������� ���������
    For Each objProcess In colProcesses
      ' ��������� ������ �������� ��������
      objProcess.Terminate
    Next
    ' ��������� ������ ���������
    RefreshProcessList
  End If
End Sub

'-----------------------------------------------------------------
' �������� �� ��������� � �������� ���������
Sub SubscribeEvents
  ' ������� ������ SWbemSink
  Set objSink = WScript.CreateObject("WbemScripting.SWbemSink", "Sink_")
  ' ��������� ������ ��� �������� �� ��������� � �������� WMI
  objService.ExecNotificationQueryAsync objSink, _
              "SELECT * FROM __InstanceCreationEvent " & _
              "WITHIN 3 WHERE TargetInstance ISA 'Win32_Process'"
End Sub

'-----------------------------------------------------------------
' ��������� - ���������� ������� OnObjectReady ������� SWbemSink
Sub Sink_OnObjectReady(oOutParams, oContext)
Dim strEventsInfo
  ' �������� ������ ��� ������        
  strEventsInfo = objDocument.all.taEventList.InnerText
  strEventsInfo = Date & " " & Time & " ������� " &_
  oOutParams.TargetInstance.Name & Chr(10) & strEventsInfo
  ' ���������� HTML-������ � ��������  
  objDocument.all.taEventList.InnerText = strEventsInfo
  ' ��������� ������ ���������
  RefreshProcessList
End Sub

'-----------------------------------------------------------------
'���������-���������� �������� ���� Internet Explorer
Sub ie_OnQuit
  bIsQuit = true
End Sub 

'-----------------------------------------------------------------
'�������� ��������� ���������
Sub Main
  ' ������� ������ WshShell
  Set WshShell = WScript.CreateObject("WScript.Shell")
  ' ������� ������ InternetExplorer.Application � ������������
  ' ��������� ������� ����� �������
  Set objIE = WScript.CreateObject(_
         "InternetExplorer.Application", "ie_")

  ' ������������� �������� ������� objIE ��� ����������� �����
  objIE.AddressBar = false
  objIE.FullScreen = false
  objIE.MenuBar    = false
  objIE.Resizable  = false
  objIE.StatusBar  = false
  objIE.ToolBar    = false
  '������������� ������� ����
  objIE.Height = 500  '������
  objIE.Width = 780   '�����

  ' ��������� HTML-���� � ������
  strPathHTML = WshShell.CurrentDirectory & "\" & "Form.htm"
  objIE.Navigate strPathHTML

  ' ���������� ��������� �������� HTML-�����
  Do While (objIE.Busy)
    Wscript.Sleep 200
  Loop   

  ' ���������� HTML-����� �� ������
  ShowForm

  bIsQuit = false
  ' ���������������� �������� �� 1 ���
  While Not bIsQuit
    WScript.Sleep 100
  Wend
End Sub

'********************** ������ *************************************
Main
' ********************* ����� **************************************
