'*******************************************************************
' Имя: NetworkAdapterInfo.vbs
' Язык: VBScript
' Описание: Вывод информации о сетевых адаптерах
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer         ' Имя компьютера
Dim strNamespace        ' Имя пространства имен
Dim objService          ' Объект SWbemServices    
Dim colNetworkAdapters  ' Коллекция экземпляров класса WMI
Dim objNetworkAdapter   ' Элемент коллекции
Dim strResult           ' Результирующая строка
Dim WshShell            ' Объект WshShell
Dim theNotepad          ' Объект WshScriptExec

' Объявляем константы
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16
Const ForWriting = 2

' Процедура для записи информации в файл 
Sub TextOut (Text, File)
  ' Объявляем переменные
  Dim  objFSO, FOut 
  ' Создаем объект FileSystemObject
  Set  objFSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' Открываем выходной файл для записи
  Set  FOut = objFSO.OpenTextFile (File,ForWriting,true)
  ' Записываем текстовую строку в файл
  FOut.WriteLine Text
  ' Закрываем выходной файл
  FOut.Close
End Sub

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strResult = "Зарегистрированные сетевые адаптеры " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)

Set colNetworkAdapters = objService.ExecQuery(_
                         "SELECT * FROM Win32_NetworkAdapter",,_
                         wbemFlagReturnImmediately+wbemFlagForwardOnly)

' Перебираем элементы коллекции 
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

' Выводим результат в текстовый файл
TextOut  strResult, "C:\NetworkAdapters.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\NetworkAdapters.txt" )
'************************* Конец ***********************************
