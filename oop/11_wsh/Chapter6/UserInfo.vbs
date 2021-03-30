'********************************************************************
' Имя: UserInfo.vbs                                               
' Язык: VBScript                                                    
' Описание: Вывод информации о пользователе компьютера и смена     
'           его пароля                                             
'********************************************************************
Option Explicit

'Объявляем переменные
Dim objUser      ' Экземпляр объекта User
Dim WshShell     ' Объект WshShell
Dim Res          ' Результат нажатия кнопки в диалоговом окне
Dim strPassword  ' Строка с новым паролем
Dim strResult    ' Строка для вывода на экран

'********************** Начало *************************************
' Связываемся с пользователем XUser компьютера Popov
Set objUser = GetObject("WinNT://Popov/XUser,user")
' Формируем строку с информацией о пользователе
strResult = "Информация о пользователе XUser" & vbCrLf &_
        "Имя: " & objUser.Name & vbCrLf & _
        "Описание: " & objUser.Description & vbCrLf
' Выводим сформированную строку на экран
WScript.Echo strResult

' Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
' Запрос на изменение пароля
Res = WshShell.Popup("Изменить пароль у XUser?",0,_
  "Администрирование пользователей",vbQuestion+vbYesNo)
If Res=vbYes Then ' Нажата кнопка Да
  ' Устанавливаем новый пароль
  objUser.SetPassword "NewPassword"
  ' Сохраняем сделанные изменения
  objUser.SetInfo
  WScript.Echo "Пароль был изменен"
Else
  WScript.Echo "Вы отказались от изменения пароля"
End If  
'*************  Конец *********************************************/
