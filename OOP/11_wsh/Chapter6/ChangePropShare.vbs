'*******************************************************************
' Имя: ChangePropShare.vbs
' Язык: VBScript
' Описание: Изменение свойств папки для совместного доступа
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim colShares         ' Коллекция экземпляров класса WMI 
Dim objShare          ' Элемент коллекции
Dim iError            ' Значение, возвращаемое методом

' Объявляем константы
Const MAXIMUM_CONNECTIONS = 5
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
  ' Изменяем свойства папки общего доступа
  iError = objShare.SetShareInfo(MAXIMUM_CONNECTIONS, _
        "Это новое описание для папки общего доступа.")
  ' Проверяем ошибки
  If iError <> 0 Then 
    ' Выводим сообщение об ошибке
    WScript.Echo "Ошибка при при изменении свойств " &_
                 " папки общего доступа."
  Else
    ' Выводим сообщение об успешном изменении свойств 
    WScript.Echo "Свойства папки общего доступа успешно изменены."
  End If
Next
'************************* Конец ***********************************
