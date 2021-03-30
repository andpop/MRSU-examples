'*******************************************************************
' Имя: PnPDeviceInfo.vbs
' Язык: VBScript
' Описание: Вывод списка установленных PnP-устройств 
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemServices    
Dim colPnPEntities    ' Коллекция экземпляров класса WMI
Dim objPnPEntity      ' Элемент коллекции
Dim strResult         ' Результирующая строка
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

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
strResult = "Зарегистрированные PnP-устройства " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
' Создаем коллекцию экземпляров класса Win32_PnPEntity
Set colPnPEntities=objService.ExecQuery("SELECT * FROM Win32_PnPEntity"_
   ,,wbemFlagReturnImmediately+wbemFlagForwardOnly)

' Перебираем элементы коллекции 
For Each objPnPEntity In colPnPEntities
  strResult = strResult & "Class GUID: " & _
              objPnPEntity.ClassGuid & VbCrLf
  strResult = strResult & "Description: " & _
              objPnPEntity.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objPnPEntity.DeviceID & VbCrLf
  strResult = strResult & "Manufacturer: " & _
              objPnPEntity.Manufacturer & VbCrLf
  strResult = strResult & "Name: " & _
              objPnPEntity.Name & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objPnPEntity.PNPDeviceID & VbCrLf
  strResult = strResult & "Service: " & _
              objPnPEntity.Service & VbCrLf
  strResult = strResult & "********************************" & VbCrLf & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\PnP.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\PnP.txt" )
'************************* Конец ***********************************
