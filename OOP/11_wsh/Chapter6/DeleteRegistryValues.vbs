'*******************************************************************
' Имя: DeleteRegistryValues.vbs
' Язык: VBScript
' Описание: Удаление из реестра текстового параметра и параметра DWORD  
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strKeyPath        ' Имя подраздела реестра
Dim strValueName      ' Имя параметра реестра
Dim objReg            ' Объект SWbemObject для работы с реестром
Dim WshShell          ' Объект WshShell
Dim Res

' Объявляем константы
const HKEY_LOCAL_MACHINE = &H80000002
'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."

'Создаем объект WshShell
Set WshShell=WScript.CreateObject("WScript.Shell")

' Получаем указатель на класс StdRegProv
Set objReg = GetObject("WinMgmts:\\" & strComputer & _
                         "\Root\Default:StdRegProv")
' Задаем имя подраздела
strKeyPath = "SOFTWARE\Example key"

' Задаем имя текстового параметра
strValueName = "Example String Value"
'Запрос на удаление параметра
Res=WshShell.Popup("Удалить параметр " & strKeyPath & "\" & _
   strValueName & "?",0,"Работа с реестром", vbQuestion+vbYesNo)
If Res=vbYes Then   'Нажата кнопка Да
  ' Выполняем метод DeleteValue
  objReg.DeleteValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName
  WshShell.Popup "Параметр " & strValueName & " удален!",0,_
     "Работа с реестром",vbInformation+vbOkOnly
End If

' Задаем имя параметра DWORD
strValueName = "Example DWORD Value"
'Запрос на удаление параметра
Res=WshShell.Popup("Удалить параметр " & strKeyPath & "\" & _
   strValueName & "?",0,"Работа с реестром",vbQuestion+vbYesNo)
If Res=vbYes Then   'Нажата кнопка Да
  ' Выполняем метод DeleteValue
  objReg.DeleteValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName
  WshShell.Popup "Параметр " & strValueName & " удален!",0,_
     "Работа с реестром",vbInformation+vbOkOnly
End If
'************************* Конец ***********************************
