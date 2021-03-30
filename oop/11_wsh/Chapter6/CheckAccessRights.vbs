'*******************************************************************
' Имя: CheckAccessRights.vbs
' Язык: VBScript
' Описание: Проверка прав доступа к подразделу реестра
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strKeyPath        ' Имя подраздела реестра
Dim objReg            ' Объект SWbemObject для работы с реестром
Dim bHasAccessRight   ' Признак наличия определенного права доступа
Dim strResult         ' Строка для вывода на экран

' Объявляем константы
const HKEY_LOCAL_MACHINE = &H80000002
const KEY_QUERY_VALUE = &H0001
const KEY_SET_VALUE = &H0002
const KEY_CREATE_SUB_KEY = &H0004
const DELETE = &H00010000

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."

' Получаем указатель на класс StdRegProv
Set objReg = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default:StdRegProv")
' Задаем имя подраздела
strKeyPath = "SOFTWARE\Example key"
strResult = "Права доступа к подразделу " & strKeyPath & ":"  & VbCrLf & VbCrLf

' Выполняем метод CheckAccess
objReg.CheckAccess HKEY_LOCAL_MACHINE, strKeyPath, KEY_QUERY_VALUE, bHasAccessRight
' Проверяем наличие права доступа
If bHasAccessRight = True Then
  strResult = strResult & "Право на чтение значений: есть" & VbCrLf
Else
  strResult = strResult & "Право на чтение значений: нет" & VbCrLf
End If	

' Выполняем метод CheckAccess
objReg.CheckAccess HKEY_LOCAL_MACHINE, strKeyPath, KEY_CREATE_SUB_KEY, bHasAccessRight
' Проверяем наличие права доступа
If bHasAccessRight = True Then
  strResult = strResult & "Право на создание подразделов: есть" & VbCrLf
Else
  strResult = strResult & "Право на создание подразделов: нет" & VbCrLf 
End If

' Выполняем метод CheckAccess
objReg.CheckAccess HKEY_LOCAL_MACHINE, strKeyPath, DELETE, bHasAccessRight
' Проверяем наличие права доступа
If bHasAccessRight = True Then
  strResult = strResult & "Право на удаление подраздела: есть" & VbCrLf 
Else
  strResult = strResult & "Право на удаление подраздела: нет" & VbCrLf 
End If

' Выводим сформированную строку на экран
WScript.Echo strResult
'************************* Конец ***********************************
