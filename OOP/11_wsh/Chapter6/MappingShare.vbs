'*******************************************************************
' Имя: MappingShare.vbs
' Язык: VBScript
' Описание: Выявление соотвествия для папок совместного доступа и 
'           реальных папок на диске
'*******************************************************************
Option Explicit

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim colShares         ' Коллекция экземпляров класса WMI 
Dim objShare          ' Элемент коллекции
Dim colAssociations   ' Коллекция экземпляров класса WMI 
Dim objFolder         ' Элемент коллекции
Dim strResult         ' Результат запроса

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strResult = "Папки общего доступа:" & VbCrLf

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_
                                   strComputer & "\" & strNamespace)
' Создаем коллекцию экземпляров класса Win32_Share
Set colShares = objService.ExecQuery("SELECT * FROM Win32_Share")

' Перебираем элементы коллекции
For Each objShare in colShares
  ' Создаем коллекцию экземпляров класса Win32_ShareToDirectory
  Set colAssociations = objService.ExecQuery _
        ("ASSOCIATORS OF {Win32_Share.Name='" & objShare.Name & "'} " _
         & " WHERE AssocClass=Win32_ShareToDirectory")
  ' Перебираем элементы коллекции 
  For Each objFolder In colAssociations
    ' Формируем строку для вывода на экран  
    strResult = strResult & "  " & objShare.Name & " - " &_
                objFolder.Name & VbCrLf
  Next
Next

' Выводим результат на экран
Wscript.Echo strResult
'************************* Конец ***********************************
