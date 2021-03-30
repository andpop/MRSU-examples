'*******************************************************************
' Имя: Sample_WMI_Tool.vbs
' Язык: VBScript
' Описание: WMI-утилита для администрирования рабочих станций
'*******************************************************************
Option Explicit

' Объявляем глобальные переменные
Dim WshShell         ' Объект WshShell
Dim objIE            ' Объект InternetExplorer.Application
Dim objDocument      ' Объект Document
Dim strPathHTML      ' Путь к HTML-форме
Dim objLocator       ' Объект SWbemLocator
Dim objService       ' Объект SWbemService
Dim objSink          ' Объект SWbemSink
Dim bIsQuit          ' Переменная-флаг выхода из цикла

'-----------------------------------------------------------------
' Отображение HTML-формы на экране
Sub ShowForm
  ' Получаем ссылку на объект Document
  Set objDocument = objIE.Document
  ' Формируем список доменов
  SeekDomains
  ' Формируем список компьютеров
  SeekComputers
  ' Делаем окно Internet Explorer видимым
  objIE.Visible = true
  ' Разрешаем кнопку "Подключить"
  objDocument.all.btnConnect.Disabled = False
  ' Делаем недоступными элементы управления в форме
  objDocument.all.btnExecuteAction.Disabled = True
  objDocument.all.btnTerminate.Disabled = True
  objDocument.all.cbUserProc.Disabled = True
  objDocument.all.txtCurrUser.Disabled = True
  objDocument.all.txtIP.Disabled = True
  objDocument.all.txtMAC.Disabled = True
  
  ' Определяем процедуры-обработчики событий элементов управления в форме
  Set objDocument.all.selDomain.onChange = GetRef("SeekComputers")
  Set objDocument.all.btnConnect.onClick = GetRef("Connect")
  Set objDocument.all.btnExecuteAction.onClick = GetRef("ExecuteAction")
  Set objDocument.all.cbUserProc.onClick = GetRef("RefreshProcessList")
  Set objDocument.all.btnTerminate.onClick = GetRef("Terminate")
End Sub 

'-----------------------------------------------------------------
' Формирование и вывод списка доступных доменов
Sub SeekDomains
  ' Объявляем переменные
  Dim objNamespace, objDomain, strHTML
  
  ' Связываемся с корневым объектом Namespace
  Set objNamespace = GetObject("WinNT:")
  ' Устанавливаем фильтр для выделения объектов-доменов
  objNamespace.Filter = Array("domain")
  ' Формируем HTML-код раскрывающегося списка доменов
  strHTML = "<SELECT STYLE='WIDTH: 150px' NAME='selDomain'>"
  strHTML = strHTML & "<OPTION VALUE=''></OPTION>"
  ' Перебираем в цикле все имеющиеся домены
  For Each objDomain In objNamespace
    ' Формируем HTML-строку с именем домена
    strHTML = strHTML & "<OPTION VALUE=" &"'" & objDomain.Name & "' >"
    strHTML = strHTML & objDomain.Name & "</OPTION>"
  Next
  ' Вставляем HTML-код в документ
  objDocument.all.optDomain.InnerHTML=strHTML
End Sub

'-----------------------------------------------------------------
' Формирование и вывод списка компьютеров в домене
Sub SeekComputers
  ' Объявляем переменные
  Dim strHTML, strDomain, objDomain, objComp
  
  strHTML = "<SELECT STYLE='WIDTH: 150px' NAME='selStation'>"
  If objDocument.all.selDomain.Value<>"" Then 'Выбран определенный домен
    ' Извлекаем имя домена
    strDomain = objDocument.all.selDomain.Value
    ' Связываемся с объектом Domain
    Set objDomain = GetObject("WinNT://" & strDomain)
    ' Перебираем все объекты домена
    For Each objComp In objDomain
      If objComp.Class = "Computer" Then
        ' Формируем HTML-строку с именем компьютера
        strHTML = strHTML & "<OPTION VALUE='" & objComp.Name & "'>" &_
                  objComp.Name & "</OPTION>"
      End If
    Next 
    strHTML = strHTML & "</SELECT>"
  Else
    ' Выбран пустой домен - работаем с локальной машиной
    strHTML = strHTML & "<OPTION VALUE='.'>.</OPTION>"
  End If  
  ' Вставляем сформированный HTML-код в документ  
  objDocument.all.optStation.InnerHTML = strHTML
End Sub

'-----------------------------------------------------------------
' Подключение к службе WMI
Sub Connect
  ' Объявляем переменные
  Dim strComputer, strUser, strIP, strMAC, strPassword, intRes
  
  On Error Resume Next
  ' Извлекаем имена компьютера, пользователя и пароль
  strComputer = objDocument.all.selStation.Value
  strUser = objDocument.all.txtUser.Value
  strPassword = objDocument.all.txtPassword.Value
  
  ' Создаем объект SWbemLocator
  Set objLocator = CreateObject("WbemScripting.SWbemLocator")
  If strComputer="." Then
    ' Соединяемся со службой WMI на локальном компьютере
    Set objService = objLocator.ConnectServer(".", "Root\CIMV2")
  Else  
    ' Соединяемся со службой WMI на удаленном компьютере
    Set objService = objLocator.ConnectServer(strComputer,"Root\CIMV2",_
                      strUser,strPassword)
  End If
  
  ' Обрабатываем ошибки
  If Err.Number <> 0 Then  ' Произошла ошибка при подключении к WMI
    ' Выводим сообщение об ошибке
    intRes = MsgBox ("Ошибка при соединении с WMI # " &_
      CStr(Err.Number) & " " & Err.Description,_
           vbOkOnly+vbInformation,"Ошибка") 
    ' Очищаем свойства объекта Err
    Err.Clear
  Else
    ' Выводим список процессов
    ShowProcesses("All")
    ' Подписываемся на извещения о событиях WMI
    SubscribeEvents
    ' Определяем имя активного пользователя
    objDocument.all.txtCurrUser.Value = GetCurrentUserName
    ' Определяем MAC- и IP-адреса сетевого адаптера
    GetNetworkAdapterInfo strIP, strMAC
    objDocument.all.txtIP.Value = strIP
    objDocument.all.txtMAC.Value = strMAC
    
    ' Делаем доступными элементы управления в форме
    objDocument.all.btnExecuteAction.Disabled = False
    objDocument.all.btnTerminate.Disabled = False
    objDocument.all.btnTerminate.Disabled = False
    objDocument.all.cbUserProc.Disabled = False
  End If  
End Sub

'-----------------------------------------------------------------
' Получение имени активного пользователя
Function GetCurrentUserName
  ' Объявляем переменные
  Dim ColUserName, objUserName
  
  ' Создаем коллекцию экземпляров класса Win32_ComputerSystem
  Set ColUserName = objService.ExecQuery _
    ("SELECT * FROM Win32_ComputerSystem")
  ' Перебираем коллекцию
  For Each objUserName In ColUserName
    ' Возвращаем имя активного пользователя
    GetCurrentUserName = objUserName.UserName
  Next 
End Function

'-----------------------------------------------------------------
' Получение IP- и MAC-адресов сетевого адаптера
Function GetNetworkAdapterInfo(ByRef strIP, ByRef strMac)
  ' Объявляем переменные
  Dim colNetworkAdapters, objNetworkAdapter, colPnPDevices
  Dim objPnpDevice, colDeviceBuses, objDeviceBus
  Dim colNetworkAdapterSettings, objNetworkAdapterSetting
  
  ' Создаем коллекцию экземпляров класса Win32_NetworkAdapter
  Set colNetworkAdapters = objService.ExecQuery(_
                       "SELECT * FROM Win32_NetworkAdapter")    
  ' Перебираем элементы коллекции
  For Each objNetworkAdapter In colNetworkAdapters
    ' Создаем коллекцию экземпляров класса Win32_PnPDevice
    Set colPnPDevices = objService.ExecQuery _
        ("ASSOCIATORS OF {Win32_NetworkAdapter.DeviceID='" & _
         objNetworkAdapter.DeviceID & "'} " &_
         " WHERE AssocClass=Win32_PnPDevice")
    ' Перебираем элементы коллекции 
    For Each objPnpDevice In colPnPDevices
      ' Создаем коллекцию соответствующих экземпляров 
      ' класса Win32_DeviceBus
      Set colDeviceBuses = objService.ExecQuery _
        ("ASSOCIATORS OF {Win32_PnPEntity.DeviceID='" & _ 
         objPnpDevice.DeviceID & "'} " &_
         " WHERE AssocClass=Win32_DeviceBus")
      ' Перебираем элементы коллекции  
      For Each objDeviceBus In colDeviceBuses
        ' Определяем MAC-адрес сетевого адаптера 
        strMac = objNetworkAdapter.MACAddress
        ' Создаем коллекцию соответствующих экземпляров класса 
        ' Win32_NetworkAdapter
        Set colNetworkAdapterSettings = objService.ExecQuery _
          ("ASSOCIATORS OF {Win32_NetworkAdapter.DeviceID='" & _
          objNetworkAdapter.DeviceID & "'} " &_
          " WHERE AssocClass = Win32_NetworkAdapterSetting")
        ' Перебираем элементы сформированной коллекции 
        For Each objNetworkAdapterSetting In colNetworkAdapterSettings
           strIP = objNetworkAdapterSetting.IPAddress(0)
        Next
      Next
    Next
  Next 
End Function

'-----------------------------------------------------------------
' Завершение сеанса пользователя
Sub Logoff
  ' Объявляем переменные
  Dim strQuery, colOS, objOS
  
  strQuery = "SELECT * FROM Win32_OperatingSystem"
  Set colOS = objService.ExecQuery(strQuery)
  For Each objOS In colOS
    objOS.Win32Shutdown(0)
  Next
End Sub

'-----------------------------------------------------------------
' Перезагрузка компьютера
Sub Reboot
  ' Объявляем переменные
  Dim strQuery, colOS, objOS
  
  strQuery = "SELECT * FROM Win32_OperatingSystem"
  Set colOS = objService.ExecQuery(strQuery)
  For Each objOS In colOS
    objOS.Reboot
  Next
End Sub

'-----------------------------------------------------------------
' Выключение компьютера
Sub Shutdown
  ' Объявляем переменные
  Dim strQuery, colOS, objOS
  
  strQuery = "SELECT * FROM Win32_OperatingSystem"
  Set colOS = objService.ExecQuery(strQuery)
  For Each objOS In colOS
    objOS.Shutdown
  Next
End Sub

'-----------------------------------------------------------------
' Выбор и выполнение нужного действия
Sub ExecuteAction
Dim intRes
  If objDocument.all.rbAction("LogoffUser").checked Then
    ' Завершаем сеанс работы активного пользователя
    intRes = MsgBox ("Завершить сеанс пользователя " &_
             objDocument.all.txtCurrUser.Value & "?",_
             vbYesNo+vbQuestion,"Действия")
    If intRes = vbYes Then
      Logoff
    End If
  ElseIf objDocument.all.rbAction("Restart").checked Then
    ' Перезагружаем компьютер
    intRes = MsgBox ("Перезагрузить компьютер " &_
             objDocument.all.selStation.Value &_
             "?",vbYesNo+vbQuestion,"Действия")
    If intRes = vbYes Then
      Reboot
    End If
  ElseIf objDocument.all.rbAction("Shutdown").checked Then
    ' Выключаем компьютер
    intRes = MsgBox ("Выключить компьютер " &_
             objDocument.all.selStation.Value &_
             "?",vbYesNo+vbQuestion,"Действия")
    If intRes = vbYes Then
      Shutdown
    End If
  End If  
End Sub

'-----------------------------------------------------------------
' Формирование и вывод списка запущенных процессов
Sub ShowProcesses(strMode)
  ' Объявляем переменные
  Dim strHTML, colProcesses, objProcess, intRes
  Dim strUserDomain,strUserName,strFullUserName
  
  strHTML = "<SELECT SINGLE STYLE='WIDTH: 280px' NAME='selProcess'Д SIZE=10>"
  ' Создаем коллекцию экземпляров класса Win32_Process
  Set colProcesses = objService.ExecQuery("SELECT * FROM Win32_Process")
  ' Перебираем элементы коллекции процессов
  For Each objProcess In colProcesses
    ' Определяем владельца процесса
    intRes = objProcess.GetOwner(strUserName,strUserDomain)
    strFullUserName = strUserDomain & "\" & strUserName
    If strMode="All" Then
      ' Выводим все процессы
      strHTML = strHTML & "<OPTION VALUE='" & objProcess.Name & "'>"
      strHTML = strHTML & objProcess.Name & "</OPTION>"
    Else
      ' Выводим только процессы пользователя
      If strFullUserName=objDocument.all.txtCurrUser.Value Then
        strHTML = strHTML & "<OPTION VALUE='" & objProcess.Name & "'>"
        strHTML = strHTML & objProcess.Name & "</OPTION>"
      End If
    End If
  Next
  strHTML = strHTML & "</SELECT>"
  ' Записываем HTML-строку в документ
  objDocument.all.optProcess.InnerHTML=strHTML
End Sub

'-----------------------------------------------------------------
' Обновление списка процессов
Sub RefreshProcessList
  If objDocument.all.cbUserProc.Checked Then
    ' Выводим только процессы пользователя
    ShowProcesses("User")
  Else
    ' Выводим все процессы
    ShowProcesses("All")
  End If
End Sub

'-----------------------------------------------------------------
' Завершение работы процесса
Sub Terminate
  ' Объявляем переменные
  Dim strProcess, strQuery, colProcesses, objProcess, intRes
  
  'Извлекаем имя выделенного процесса из списка
  strProcess = objDocument.all.selProcess.Value
  ' Выводим запрос на завершение процесса
  intRes = MsgBox ("Завершить процесс " & strProcess & "?",_
    vbYesNo+vbQuestion,"Процессы")
  If intRes = vbYes Then
    strQuery = "SELECT * FROM Win32_Process WHERE Name='" &_
                strProcess & "'"
    ' Формируем коллекцию процессов с именем strProcess
    Set colProcesses = objService.ExecQuery(strQuery)
    ' Перебираем коллекцию процессов
    For Each objProcess In colProcesses
      ' Завершаем работу текущего процесса
      objProcess.Terminate
    Next
    ' Обновляем список процессов
    RefreshProcessList
  End If
End Sub

'-----------------------------------------------------------------
' Подписка на извещения о создании процессов
Sub SubscribeEvents
  ' Создаем объект SWbemSink
  Set objSink = WScript.CreateObject("WbemScripting.SWbemSink", "Sink_")
  ' Выполняем запрос для подписки на извещения о событиях WMI
  objService.ExecNotificationQueryAsync objSink, _
              "SELECT * FROM __InstanceCreationEvent " & _
              "WITHIN 3 WHERE TargetInstance ISA 'Win32_Process'"
End Sub

'-----------------------------------------------------------------
' Процедура - обработчик события OnObjectReady объекта SWbemSink
Sub Sink_OnObjectReady(oOutParams, oContext)
Dim strEventsInfo
  ' Формирум строку для вывода        
  strEventsInfo = objDocument.all.taEventList.InnerText
  strEventsInfo = Date & " " & Time & " запущен " &_
  oOutParams.TargetInstance.Name & Chr(10) & strEventsInfo
  ' Записываем HTML-строку в документ  
  objDocument.all.taEventList.InnerText = strEventsInfo
  ' Обновляем список процессов
  RefreshProcessList
End Sub

'-----------------------------------------------------------------
'Процедура-обработчик закрытия окна Internet Explorer
Sub ie_OnQuit
  bIsQuit = true
End Sub 

'-----------------------------------------------------------------
'Основная запускная процедура
Sub Main
  ' Создаем объект WshShell
  Set WshShell = WScript.CreateObject("WScript.Shell")
  ' Создаем объект InternetExplorer.Application с возможностью
  ' обработки событий этого объекта
  Set objIE = WScript.CreateObject(_
         "InternetExplorer.Application", "ie_")

  ' Устанавливаем свойства объекта objIE для отображения формы
  objIE.AddressBar = false
  objIE.FullScreen = false
  objIE.MenuBar    = false
  objIE.Resizable  = false
  objIE.StatusBar  = false
  objIE.ToolBar    = false
  'Устанавливаем размеры окна
  objIE.Height = 500  'Высота
  objIE.Width = 780   'Длина

  ' Загружаем HTML-файл с формой
  strPathHTML = WshShell.CurrentDirectory & "\" & "Form.htm"
  objIE.Navigate strPathHTML

  ' Дожидаемся окончания загрузки HTML-формы
  Do While (objIE.Busy)
    Wscript.Sleep 200
  Loop   

  ' Отображаем HTML-форму на экране
  ShowForm

  bIsQuit = false
  ' Приостанавливаем сценарий на 1 сек
  While Not bIsQuit
    WScript.Sleep 100
  Wend
End Sub

'********************** Начало *************************************
Main
' ********************* Конец **************************************
