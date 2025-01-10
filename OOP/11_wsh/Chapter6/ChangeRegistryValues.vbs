'*******************************************************************
' Имя: ChangeRegistryValues.vbs
' Язык: VBScript
' Описание: Изменение значений параметров реестра
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strKeyPath        ' Имя подраздела реестра
Dim strValueName      ' Имя параметра реестра
Dim strValue          ' Значение текстового параметра реестра
Dim dwValue           ' Значение параметра DWORD реестра 
Dim objReg            ' Объект SWbemObject для работы с реестром
Dim WshShell          ' Объект WshShell
Dim Res

' Объявляем константы
const HKEY_LOCAL_MACHINE = &H80000002
'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."

' Задаем имя подраздела
strKeyPath = "SOFTWARE\Example key"

'Создаем объект WshShell
Set WshShell=WScript.CreateObject("WScript.Shell")

' Получаем указатель на класс StdRegProv
Set objReg = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default:StdRegProv")
' Задаем имя текстового параметра
strValueName = "Example String Value"
' Задаем новое значение параметра
strValue = "New string value"
'Запрос на изменение значения параметра
Res=WshShell.Popup("Изменить значение параметра " & strValueName &_
       "?",0,"Работа с реестром",vbQuestion+vbYesNo)
If Res=vbYes Then   'Нажата кнопка Да
  ' Выполняем метод SetStringValue
  objReg.SetStringValue HKEY_LOCAL_MACHINE, strKeyPath, _
      strValueName, strValue
  WshShell.Popup "Значение параметра " & strValueName & _
     " изменено!",0,"Работа с реестром",vbInformation+vbOkOnly
End If

' Задаем имя параметра DWORD
strValueName = "Example DWORD Value"
' Задаем новое значение параметра
dwValue = 300
'Запрос на изменение значения параметра
Res=WshShell.Popup("Изменить значение параметра " & strValueName &_
       "?",0,"Работа с реестром",vbQuestion+vbYesNo)
If Res=vbYes Then   'Нажата кнопка Да
  ' Выполняем метод SetDWORDValue
  objReg.SetDWORDValue HKEY_LOCAL_MACHINE, strKeyPath, _
    strValueName, dwValue
  WshShell.Popup "Значение параметра " & strValueName & _
     " изменено!",0,"Работа с реестром",vbInformation+vbOkOnly
End If
'************************* Конец ***********************************
