'*******************************************************************
' Имя: DeleteShare.vbs
' Язык: VBScript
' Описание: Удаление папки для совместного доступа
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim colShares         ' Коллекция экземпляров класса WMI 
Dim objShare          ' Элемент коллекции
Dim iError            ' Значение, возвращаемое методом

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_
                                   strComputer & "\" & strNamespace)
' Создаем коллекцию экземпляров класса Win32_Share
Set colShares = objService.ExecQuery _
            ("SELECT * FROM Win32_Share WHERE Name = 'NewShare'")

' Перебираем элементы коллекции
For Each objShare In colShares
  ' Удаляем папку общего доступа
  iError = objShare.Delete
  ' Проверяем ошибки
  If iError <> 0 Then 
    ' Выводим сообщение об ошибке
    WScript.Echo "Ошибка при удалении папки общего доступа."
  Else
    ' Выводим сообщение об успешном удалении 
    WScript.Echo "Папка общего доступа успешно удалена."
  End If
Next
'************************* Конец ***********************************
