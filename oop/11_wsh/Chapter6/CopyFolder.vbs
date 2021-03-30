'*******************************************************************
' Имя: CopyFolder.vbs
' Язык: VBScript
' Описание: Копирование папки C:\Test в папку D:\Test_Archive
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim iError            ' Значение, возвращаемое методом
Dim colFolders        ' Коллекция экземпляров класса WMI
Dim objFolder         ' Элемент коллекции

' Объявляем константы
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)
' Создаем коллекцию экземпляров класса Win32_Directory
Set colFolders = objService.ExecQuery(_
      "SELECT * FROM Win32_Directory WHERE Name = 'c:\\Test'",,_
      wbemFlagReturnImmediately + wbemFlagReturnImmediately)

' Перебираем элементы коллекции
For Each objFolder in colFolders
  ' Копируем папку
  iError = objFolder.Copy("D:\Test_Archive")
  ' Проверяем ошибки
  If iError <> 0 Then
    WScript.Echo "Ошибка при копировании папки."
  Else 
    WScript.Echo "Копирование прошло успешно."
  End If
Next
'************************* Конец ***********************************
