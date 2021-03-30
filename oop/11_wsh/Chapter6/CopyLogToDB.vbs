'*******************************************************************
' Имя: CopyLogToDB.vbs
' Язык: VBScript
' Описание: Копирование записей из журнала событий в базу данных
'*******************************************************************
Option Explicit
On Error Resume Next

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim colEvents         ' Коллекция экземпляров класса WMI
Dim objEvent          ' Элемент коллекции
Dim strSQLCommand     ' Строка для создания таблицы
Dim objConnect        ' Объект ADODB.Connection
Dim objRecordset      ' Объект ADODB.Recordset

' Объявляем константы
const adExecuteNoRecords = &H80
const adUseClient = 3
const adOpenStatic = 3
const adLockOptimistic = 3

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
' SQL-команда для создания таблицы для записей из журналов событий
strSQLCommand = "CREATE TABLE EVENTLOGS ( " &_
                " LogFile varchar (20),   " &_
                " Category varchar (20),  " &_
                " CompName varchar (50),  " &_
                " EventCode varchar (20), " &_
                " Message varchar(254) ,  " &_
                " RecNumber varchar (10), " &_
                " Source varchar (50),    " &_
                " TimeRec varchar (50),   " &_
                " Type varchar (20),      " &_
                " User varchar (50)       " &_
                " ) " 
' Создаем объект ADODB.Connection
Set objConnect = CreateObject("ADODB.Connection")
' Создаем объект ADODB.Recordset
Set objRecordset = CreateObject("ADODB.Recordset")

' Устанавливаем соединение с источником данных
objConnect.Open "DSN=EventLog_DBF;"

' Создаем новую таблицу для хранения записей
objConnect.Execute strSQLCommand,,adExecuteNoRecords
' Обрабатываем ошибки
if Err.Number = 0 then  
  ' Выводим сообщение об создании таблицы
  MsgBox "Создана таблица EVENTLOGS " 
end if

objRecordset.CursorLocation = adUseClient

' Открываем набор данных
objRecordset.Open "SELECT * FROM EVENTLOGS" , objConnect, _
                             adOpenStatic, adLockOptimistic
' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_ 
                           strComputer & "\" & strNamespace) 

' Создаем коллекцию экземпляров класса Win32_NTLogEvent
Set colEvents = objService.ExecQuery _
                          ("SELECT * FROM Win32_NTLogEvent")
' Перебираем элементы коллекции     
For Each objEvent In colEvents
  ' Добавляем новую запись  
  objRecordset.AddNew
  ' Заполняем поля записи
  objRecordset("LogFile") = objEvent.LogFile
  objRecordset("Category") = objEvent.Category
  objRecordset("CompName") = objEvent.ComputerName
  objRecordset("EventCode") = objEvent.EventCode
  objRecordset("Message") = left (objEvent.Message,254)
  objRecordset("RecNumber") = objEvent.RecordNumber
  objRecordset("Source") = objEvent.SourceName
  objRecordset("TimeRec") = WMIDateStr(objEvent.TimeWritten)
  objRecordset("Type") = objEvent.Type
  objRecordset("User") = objEvent.User
  ' Сохраняем запись
  objRecordset.Update
Next

' Удаляем объект ADODB.Recordset
objRecordset.Close
' Удаляем объект ADODB.Connection
objConnect.Close

' Выводим сообщение об завершении копирования данных
WScript.Echo "Копирование данных успешно завершено"
'************************* Конец ***********************************
