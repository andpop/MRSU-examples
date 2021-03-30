'********************************************************************
' Имя: MapResources.vbs
' Язык: VBScript
' Описание: Отключение и подключение сетевых дисков и принтеров
'********************************************************************
Option Explicit

' Объявляем переменные
Dim WshNetwork,Drive,NetPath,Port,NetPrinter

Drive="K:"   ' Буква диска
NetPath="\\RS_NT_Server\d"    ' Сетевой путь для подключения диска
Port="LPT1"   ' Название локального порта
' Сетевой путь для подключения принтера
NetPrinter="\\104_Stepankova\HP"

' Создаем объект WshNetwork
Set WshNetwork = WScript.CreateObject("WScript.Network")
' Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")

On Error Resume Next  ' Включаем обработку ошибок времени выполнения
'*************  Отключение сетевого диска  ***********************
' Отключаем сетевой диск
WshNetwork.RemoveNetworkDrive Drive
If Err.Number<>0 Then
  Mess="Ошибка при отключении диска " & Drive & vbCrLf & _
       "Код ошибки: " &  e.number & vbCrLf &+ _
       "Описание: " & e.description
  WshShell.Popup Mess,0,"Отключение сетевого диска",vbCritical
Else
  ' Все в порядке
  Mess="Диск " & Drive & " отключен успешно"
  WshShell.Popup Mess,0,"Отключение сетевого диска",vbInformation
End If

'*************  Подключение сетевого диска  ***********************
' Подключаем сетевой диск
WshNetwork.MapNetworkDrive Drive,NetPath
If Err.Number<>0 Then
  Mess="Ошибка при подключении диска " & Drive & " к " & NetPath &_
       "Код ошибки: " & e.number & "Описание: " & e.description
  WshShell.Popup Mess,0,"Подключение сетевого диска",vbCritical
Else
  ' Все в порядке
  Mess="Диск " & Drive & " успешно подключен к " & NetPath
  WshShell.Popup Mess,0,"Подключение сетевого диска",vbInformation
End If

'*************  Освобождение локального порта  ***********************
' Разрываем связь с сетевым принтером
WshNetwork.RemovePrinterConnection Port
If Err.Number<>0 Then
  Mess="Ошибка при отключении порта " & Port & "Код ошибки: " &_
        e.number & "Описание: " & e.description
  WshShell.Popup Mess,0,"Отключение порта от сетевого ресурса",vbCritical
Else
  ' Все в порядке
  Mess="Порт " & Port & " отключен успешно"
  WshShell.Popup Mess,0,"Отключение порта от сетевого ресурса",_
                 vbInformation
End If

'*****  Подключение локального порта  к сетевому принтеру  *********
' Подключаем сетевой принтер к локальному порту
WshNetwork.AddPrinterConnection Port,NetPrinter
If Err.Number<>0 Then
  Mess="Ошибка при переназначении порта " & Port & " на " & NetPrinter &_
       "Код ошибки: " & e.number & "Описание: " & e.description
  WshShell.Popup Mess,0,"Подключение порта к сетевому ресурсу",vbCritical
Else
  ' Все в порядке
  Mess="Порт " & Port & " успешно подключен к " & NetPrinter
  WshShell.Popup Mess,0,"Подключение порта к сетевому ресурсу",
                 vbInformation
End If
'*************  Конец *********************************************
