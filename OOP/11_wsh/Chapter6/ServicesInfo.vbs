'*******************************************************************
' Имя: ServicesInfo.vbs
' Язык: VBScript
' Описание: Вывод информации о службах 
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objWMIService        ' Объект SWbemServices    
Dim colServices       ' Коллекция экземпляров класса WMI
Dim objService        ' Элемент коллекции
Dim strResult         ' Результирующая строка
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

' Объявляем константы
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16
Const ForWriting = 2

' Функция для записи информации в файл 
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
strResult = "Информация о службах " & VbCrLf & VbCrLf

' Подключаемся к пространству имен WMI
Set objWMIService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)

Set colServices = objWMIService.ExecQuery("SELECT * FROM Win32_Service"_
                  ,,wbemFlagReturnImmediately+wbemFlagForwardOnly)
For Each objService In colServices
  strResult = strResult & "Name: " & _
              objService.Name & VbCrLf
  strResult = strResult & "Display Name: " & _
              objService.DisplayName & VbCrLf
  strResult = strResult & "Caption: " & _
              objService.Caption & VbCrLf
  strResult = strResult & "Description: " & _
              objService.Description & VbCrLf
  strResult = strResult & "Path Name: " & _
              objService.PathName & VbCrLf
  strResult = strResult & "ServiceType: " & _
              objService.ServiceType & VbCrLf
  strResult = strResult & "Status: " & _
              objService.Status & VbCrLf
  strResult = strResult & "State: " & _
              objService.State & VbCrLf
  strResult = strResult & "Started: " & _
              objService.Started & VbCrLf
  strResult = strResult & "Start Mode: " & _
              objService.StartMode & VbCrLf
  strResult = strResult & "Start Name: " & _
              objService.StartName & VbCrLf
  strResult = strResult & "Accept pause: " & _
              objService.AcceptPause & VbCrLf
  strResult = strResult & "Accept stop: " & _
              objService.AcceptStop & VbCrLf
  strResult = strResult & "********************************" & VbCrLf &_
              VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\Services.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\Services.txt" )
'************************* Конец ***********************************
