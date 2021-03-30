'*******************************************************************
' Имя: Shutdown.vbs
' Язык: VBScript
' Описание: Выключение компьютера
'*******************************************************************
Option Explicit
On Error Resume Next
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colInstances      ' Коллекция экземпляров класса WMI
Dim objInstance       ' Элемент коллекции
Dim iAnswer           ' Код возврата функции MsgBox

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_OperatingSystem"

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:{(Shutdown,RemoteShutdown)}\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_OperatingSystem
Set colInstances = objClass.Instances_

' Перебираем элементы коллекции 
For Each objInstance In colInstances
  ' Выводим на экран предупреждение
  iAnswer = MsgBox("Выключить компьютер " & objInstance.CSNAME & " ?", _
                  vbQuestion + vbOKCancel, "Внимание!")

  If iAnswer = vbOK Then 
    ' Выводим сообщение о перезагрузке
    WScript.Echo "Компьютер " &  objInstance.CSNAME & " будет выключен"  
    ' Вызываем метод Shutdown
    objInstance.Shutdown()

    If Err.number <> 0 Then
      WScript.Echo  "Номер ошибки: " & Err.Number & vbNewLine & _
                    "Описание: " & Err.Description
    End If
  Else 
    ' Выводим сообщение об отмене операции
    WScript.Echo  "Не будем пока выключать"
  End if
Next
'************************* Конец ***********************************
