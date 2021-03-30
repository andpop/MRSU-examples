'*******************************************************************
' Имя: GetProcessOwner.vbs
' Язык: VBScript
' Описание: Определение владельца процесса 
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemServices    
Dim colProcesses      ' Коллекция экземпляров класса WMI
Dim objProcess        ' Элемент коллекции
Dim strUserName       ' Имя пользователя
Dim strUserDomain     ' Домен, в котором зарегистрирован пользователь
Dim intRes            ' Результат выполнения метода
Dim strResult         ' Результирующая строка

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" & _
                                   strComputer & "\" & strNamespace)
' Создаем коллекцию процессов с именем strProcess
Set colProcesses = objService.ExecQuery _
    ("SELECT * FROM Win32_Process WHERE Name='NOTEPAD.EXE'")

' Перебираем коллекцию процессов    
For Each objProcess In colProcesses
  ' Определяем владельца процесса objProcess
  intRes = objProcess.GetOwner(strUserName,strUserDomain)
  If intRes=0 Then
    ' Выводим информацию о владельце процесса
    WScript.Echo "Владельцем процесса " & objProcess.Name &_
      " является " & strUserDomain & "\" & strUserName
  Else
    ' Выводим информацию об ошибке
    WScript.Echo "Ошибка при определении владельцам процесса " _
      & objProcess.Name
  End If   
Next
'************************* Конец ***********************************
