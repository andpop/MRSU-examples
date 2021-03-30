'*******************************************************************
' Имя: ListLogProperties.vbs
' Язык: VBScript
' Описание: Вывод свойств журнала событий системы
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim colLogFiles       ' Коллекция экземпляров класса WMI
Dim objLogFile        ' Элемент коллекции
Dim strResult         ' Результат запроса

' Функция для конвертации даты формата WMI в строку
Function WMIDateStr(WMIDate)
    WMIDateStr = CDate(Mid(WMIDate, 5, 2) & "." & _
         Mid(WMIDate, 7, 2)  & "." &_
         Left(WMIDate, 4)    & " " &_
         Mid(WMIDate, 9, 2)  & ":" & _
         Mid(WMIDate, 11, 2) & ":" & _
         Mid(WMIDate, 13, 2))
End Function

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strResult = "Свойства журнала событий System: " & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_ 
                           strComputer & "\" & strNamespace) 
' Создаем коллекцию экземпляров класса Win32_NTEventLogFile
Set colLogFiles = objService.ExecQuery _
   ("SELECT * FROM Win32_NTEventLogFile WHERE LogFileName='System'")
    
' Перебираем элементы коллекции     
For Each objLogFile In colLogFiles
  ' Формируем строку для вывода файл  
  strResult = strResult & VbCrLf  &_    
     "Caption: " & objLogFile.Caption & VbCrLf &_ 
     "Compressed: " & objLogFile.Compressed & VbCrLf &_
     "CreationDate: " & WMIDateStr(objLogFile.CreationDate) & VbCrLf &_ 
     "CSName: " & objLogFile.CSName & VbCrLf &_ 
     "Description: " & objLogFile.Description & VbCrLf &_ 
     "Drive: " & objLogFile.Drive & VbCrLf &_ 
     "Extension: " & objLogFile.Extension & VbCrLf &_
     "FileName: " & objLogFile.FileName & VbCrLf &_ 
     "FileSize: " & objLogFile.FileSize & VbCrLf &_ 
     "FileType: " & objLogFile.FileType & VbCrLf &_ 
     "FSName: " & objLogFile.FSName & VbCrLf  &_
     "Hidden: " & objLogFile.Hidden & VbCrLf &_ 
     "InstallDate: " & WMIDateStr(objLogFile.InstallDate) & VbCrLf &_ 
     "LastAccessed: " & WMIDateStr(objLogFile.LastAccessed) & VbCrLf &_ 
     "LastModified: " & WMIDateStr(objLogFile.LastModified) & VbCrLf &_ 
     "LogfileName: " & objLogFile.LogfileName & VbCrLf &_ 
     "MaxFileSize: " & objLogFile.MaxFileSize & VbCrLf &_ 
     "Name: " & objLogFile.Name & VbCrLf &_ 
     "NumberOfRecords: " & objLogFile.NumberOfRecords & VbCrLf &_ 
     "OverwriteOutDated: " & objLogFile.OverwriteOutDated & VbCrLf &_
     "OverWritePolicy: " & objLogFile.OverWritePolicy & VbCrLf &_
     "Path: " & objLogFile.Path & VbCrLf &_ 
     "Status: " & objLogFile.Status 
 Next

' Выводим результат на экран
WScript.Echo strResult
'************************* Конец **********************************
