'*******************************************************************
' Имя: CopyMP3File.vbs
' Язык: VBScript
' Описание: Копирование всех файлов с расширением MP3 в папку D:\MyMP3 
'*******************************************************************
Option Explicit
On Error Resume Next

' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim objService        ' Объект SWbemService
Dim colFiles          ' Коллекция экземпляров класса WMI
Dim objFile           ' Элемент коллекции
Dim iError            ' Значение, возвращаемое методом
Dim objFSO            ' Объект FileSystemObject
Dim strFileName       ' Переменная для пути и имени копируемого файла
Dim strFolder         ' Имя папки в которую копируем файлы
Dim strExt            ' Расширение копируемых файлов

' Объявляем константы
Const wbemFlagForwardOnly = 32
Const wbemFlagReturnImmediately = 16

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strFolder = "D:\MyMP3\"
strExt = "mp3"

' Создаем объект FileSystemObject
Set objFSO = CreateObject("Scripting.FileSystemObject")
' Создаем папку
objFSO.CreateFolder(strFolder)

' Подключаемся к пространству имен WMI
Set objService = GetObject("WinMgmts:\\" &_
                           strComputer & "\" & strNamespace)

' Создаем коллекцию экземпляров класса CIM_DataFile
Set colFiles = objService.ExecQuery(_
      "SELECT * FROM CIM_DataFile WHERE Drive = 'C:'" &_
      " AND Extension = '" & strExt & "'",,wbemFlagReturnImmediately _
                                  + wbemFlagReturnImmediately)
' Перебираем элементы коллекции
For Each objFile In colFiles
  ' Формируем строку для копирования
  strFileName = strFolder & objFile.FileName & "." & objFile.Extension
  ' Проверяем не находится ли файл, в папке в которую мы копируем
  If LCase(objFile.Name) <> LCase(strFileName) Then
    ' Копируем файлы
    iError = objFile.Copy(strFileName)
    ' Проверяем ошибки
    If iError <> 0 Then
      ' Выводим сообщение об ошибке 
      WScript.Echo "Ошибка при копировании файла " &_
                         objFile.FileName & "." & objFile.Extension
    End If
  End If
Next

WScript.Echo "Копирование завершено."
'************************* Конец ***********************************
