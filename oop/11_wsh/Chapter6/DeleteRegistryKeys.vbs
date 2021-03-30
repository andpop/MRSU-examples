'*******************************************************************
' Имя: DeleteRegistryKeys.vbs
' Язык: VBScript
' Описание: Удаление из реестра подраздела  
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strKeyPath        ' Имя подраздела реестра
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
'Запрос на удаление параметра
Res=WshShell.Popup("Удалить параметр " & strKeyPath & _
   strValueName & "?",0,"Работа с реестром", vbQuestion+vbYesNo)
If Res=vbYes Then   'Нажата кнопка Да
  ' Выполняем метод DeleteValue
  objReg.DeleteKey HKEY_LOCAL_MACHINE, strKeyPath
  WshShell.Popup "Раздел" & strKeyPath & " удален!",0,_
    "Работа с реестром",vbInformation+vbOkOnly
End If
'************************* Конец ***********************************
