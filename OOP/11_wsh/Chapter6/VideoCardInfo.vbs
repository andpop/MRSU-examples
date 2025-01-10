'*******************************************************************
' Имя: VideoCardInfo.vbs
' Язык: VBScript
' Описание: Вывод информации о видеокарте
'*******************************************************************
Option Explicit

Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colVideoCont      ' Коллекция экземпляров класса WMI
Dim objVideoCont      ' Элемент коллекции
Dim strResult         ' Результирующая строка
Dim WshShell          ' Объект WshShell
Dim theNotepad        ' Объект WshScriptExec

' Объявляем константы
Const ForWriting = 2

' Процедура для записи информации в файл 
Sub TextOut (Text, File)
  ' Объявляем переменные
  Dim  objFSO, FOut 
  ' Создаем объект FileSystemObject
  Set  objFSO=WScript.CreateObject("Scripting.FileSystemObject")
  ' Открываем выходной файл для записи
  Set  FOut = objFSO.OpenTextFile (File,ForWriting,true)
  ' Записываем текстовую строку в файл
  FOut.WriteLine Text
  ' Закрываем выходной файл
  FOut.Close
End Sub

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_VideoController"
strResult = "Информация о видеокарте:" & vbCrLf & vbCrLf

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_VideoController
Set colVideoCont = objClass.Instances_

' Перебираем элементы коллекции 
For Each objVideoCont In colVideoCont
  strResult = strResult & "Adapter Compatibility: " & _
              objVideoCont.AdapterCompatibility & VbCrLf
  strResult = strResult & "Adapter DAC Type: " & _
              objVideoCont.AdapterDACType & VbCrLf
  strResult = strResult & "Adapter RAM: " & _
              objVideoCont.AdapterRAM & VbCrLf
  strResult = strResult & "Color Table Entries: " & _
              objVideoCont.ColorTableEntries & VbCrLf
  strResult = strResult & "Current Bits Per Pixel: " & _
              objVideoCont.CurrentBitsPerPixel & VbCrLf
  strResult = strResult & "Current Horizontal Resolution: " & _
              objVideoCont.CurrentHorizontalResolution & VbCrLf
  strResult = strResult & "Current Number Of Colors: " & _
              objVideoCont.CurrentNumberOfColors & VbCrLf
  strResult = strResult & "Current Refresh Rate: " & _
              objVideoCont.CurrentRefreshRate & VbCrLf
  strResult = strResult & "Current Refresh Rate: " & _
              objVideoCont.CurrentRefreshRate & VbCrLf
  strResult = strResult & "Current Vertical Resolution: " & _
              objVideoCont.CurrentVerticalResolution & VbCrLf
  strResult = strResult & "Description: " & _
              objVideoCont.Description & VbCrLf
  strResult = strResult & "Device ID: " & _
              objVideoCont.DeviceID & VbCrLf
  strResult = strResult & "Device Specific Pens: " & _
              objVideoCont.DeviceSpecificPens & VbCrLf
  strResult = strResult & "Driver Date: " & _
              objVideoCont.DriverDate & VbCrLf
  strResult = strResult & "Driver Version: " & _
              objVideoCont.DriverVersion & VbCrLf
  strResult = strResult & "INF Filename: " & _
              objVideoCont.InfFilename & VbCrLf
  strResult = strResult & "INF Section: " & _
              objVideoCont.InfSection & VbCrLf
  strResult = strResult & "Installed Display Drivers: " & _
              objVideoCont.InstalledDisplayDrivers & VbCrLf
  strResult = strResult & "Name: " & _
              objVideoCont.Name & VbCrLf
  strResult = strResult & "PNP Device ID: " & _
              objVideoCont.PNPDeviceID & VbCrLf
  strResult = strResult & "Specification Version: " & _
              objVideoCont.SpecificationVersion & VbCrLf
  strResult = strResult & "Video Architecture: " & _
              objVideoCont.VideoArchitecture & VbCrLf
  strResult = strResult & "Video Memory Type: " & _
              objVideoCont.VideoMemoryType & VbCrLf
  strResult = strResult & "Video Mode Description: " & _
              objVideoCont.VideoModeDescription & VbCrLf
Next

' Выводим результат в текстовый файл
TextOut  strResult, "C:\video.txt" 

'Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
'Открываем созданный файл в Блокноте
Set theNotepad = WshShell.Exec("notepad " & "C:\video.txt" )
'************************* Конец ***********************************
