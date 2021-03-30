'********************************************************************
' Имя: AddGroup.vbs                                                  
' Язык: VBScript                                                    
' Описание: Создание новой группы на компьютере
'********************************************************************
Option Explicit

'Объявляем переменные
Dim objComputer        ' Экземпляр объекта Computer
Dim objGroup           ' Экземпляр объекта Group
Dim strGroup           ' Имя создаваемой группы

' Задаем имя пользователя
strGroup = "XGroup"
' Связываемся с компьютером Popov
Set objComputer = GetObject("WinNT://Popov")
' Создаем объект класса Group
Set objGroup = objComputer.Create("group",strGroup)
' Сохраняем информацию на компьютере
objGroup.SetInfo
'*************  Конец *********************************************
