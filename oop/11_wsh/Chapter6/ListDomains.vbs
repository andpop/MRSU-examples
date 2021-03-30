'*******************************************************************
' Имя: ListDomains.vbs                                              
' Язык: VBScript                                                    
' Описание: Вывод на экран списка всех доменов локальной сети     
'*********************************************************************
Option Explicit

'Объявляем переменные
Dim objNameSpace        ' Корневой объект Namespace
Dim objDomain           ' Экземпляр объекта Domain
Dim strResult           ' Строка для вывода на экран

'Связываемся с корневым объектом Namespace
Set objNameSpace = GetObject("WinNT:")
'Устанавливаем фильтр для выделения объектов-доменов
objNameSpace.Filter = Array("domain")

strResult = "Все доступные домены в сети:" & vbCrLf & vbCrLf

' Перебираем элементы коллекции 
For Each objDomain In objNameSpace
  'Формируем строку с именами доменов
  strResult = strResult & objDomain.Name & vbCrLf
Next

'Вывод информацию на экран
WScript.Echo strResult
'*************  Конец *********************************************
