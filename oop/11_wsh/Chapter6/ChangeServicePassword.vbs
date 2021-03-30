'*******************************************************************
' Имя: ChangeServicePassword.vbs
' Язык: VBScript
' Описание: Изменение пароля учетной записи, от имени которой работает 
'            служба
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strService        ' Имя пространства имен
Dim objWMIService     ' Объект SWbemServices    
Dim colServices       ' Коллекция экземпляров класса WMI
Dim objService        ' Элемент коллекции
Dim intErr            ' Код возврата
Dim strPassw          ' Пароль
Dim WshShell          ' Объект WshShell

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strService = "W3SVC"
strPassw = "DerParol"

' Подключаемся к пространству имен WMI
Set objWMIService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

' Формируем коллекцию служб с именем W3SVC
Set colServices = objWMIService.ExecQuery _
    ("SELECT * FROM Win32_Service WHERE Name = '" & strService & "'")
    
' Перебираем коллекцию    
For Each objService In colServices
    ' Запускаем метод Change для службы
    intErr = objService.Change( , , , , , , , strPassw)
    If intErr=0 Then
      ' Выводим сообщение об удачном изменении пароля
      WshShell.Popup "Пароль для запуска службы " & strService & " изменен!",0,_
        "Изменение пароля службы",vbInformation+vbOkOnly
    Else
      ' Выводим сообщение об ошибке при изменении пароля
      WshShell.Popup _
        "Ошибка при изменении пароль для запуска службы " & strService _
        & "!",0,"Изменение пароля службы",vbExclamation+vbOkOnly
    End If
Next
'************************* Конец ***********************************
