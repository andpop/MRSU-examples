'*******************************************************************
' Имя: CreateRegistryElements.vbs
' Язык: VBScript
' Описание: Создание в реестре нового подраздела и параметра  
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
                         
'Запрос на создание нового ключа
Res=WshShell.Popup("Создать ключ " & strKeyPath & "?",0,_
  "Работа с реестром",vbQuestion+vbYesNo)
If Res=vbYes Then   'Нажата кнопка Да
  ' Создаем подраздел в разделе HKEY_LOCAL_MACHINE
  objReg.CreateKey HKEY_LOCAL_MACHINE,strKeyPath
  WshShell.Popup "Ключ " & strKeyPath & " создан!",0,_
    "Работа с реестром",vbInformation+vbOkOnly
Else
  WScript.Quit(0)  
End If  

' Задаем имя текстового параметра
strValueName = "Example String Value"
' Задаем значение текстового параметра
strValue = "string value"
'Запрос на запись нового параметра
Res=WshShell.Popup("Записать параметр" & strValueName & "?",0,_
      "Работа с реестром",vbQuestion+vbYesNo)
If Res=vbYes Then   'Нажата кнопка Да
  ' Вызываем метод SetStringValue
  objReg.SetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,strValue
  WshShell.Popup "Параметр " & strValueName & _
      " записан!",0,"Работа с реестром",vbInformation+vbOkOnly
Else      
  WScript.Quit(0)  
End If  

' Задаем имя параметра DWORD
strValueName = "Example DWORD Value"
' Задаем значение параметра DWORD
dwValue = 100
'Запрос на запись нового параметра
Res=WshShell.Popup("Записать параметр " & strValueName & "?",0,_
      "Работа с реестром",vbQuestion+vbYesNo)
If Res=vbYes Then   'Нажата кнопка Да
  ' Вызываем метод SetDWORDValue
  objReg.SetDWORDValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,dwValue
  WshShell.Popup "Параметр " & strValueName & _
     " записан!",0,"Работа с реестром",vbInformation+vbOkOnly
Else      
  WScript.Quit(0)  
End If  
'************************* Конец ***********************************
