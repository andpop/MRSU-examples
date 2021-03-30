'*******************************************************************
' Имя: ReadRegistryElements.vbs
' Язык: VBScript
' Описание: Чтение из реестра текстового параметра и параметра DWORD  
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strKeyPath        ' Имя подраздела реестра
Dim strValueName      ' Имя параметра реестра
Dim strValue          ' Значение текстового параметра реестра
Dim dwValue           ' Значение параметра DWORD реестра 
Dim objReg            ' Объект SWbemObject для работы с реестром

' Объявляем константы
const HKEY_LOCAL_MACHINE = &H80000002
'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."

' Получаем указатель на класс StdRegProv
Set objReg = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default:StdRegProv")
' Задаем имя подраздела
strKeyPath = "SOFTWARE\Example key"
' Задаем имя текстового параметра
strValueName = "Example String Value"
' Выполняем метод GetStringValue
objReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,strValue
' Выводим значение параметра реестра
WScript.Echo "Значение параметра " & strKeyPath & "\" &_
             strValueName & ": " & strValue

' Задаем имя параметра DWORD
strValueName = "Example DWORD Value"
' Выполняем метод GetDWORDValue
objReg.GetDWORDValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,dwValue
' Выводим значение параметра реестра
WScript.Echo "Значение параметра " & strKeyPath & "\" &_
             strValueName & ": " & dwValue
'************************* Конец ***********************************
