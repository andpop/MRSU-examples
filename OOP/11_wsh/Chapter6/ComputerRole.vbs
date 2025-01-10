'*******************************************************************
' Имя: ComputerRole.vbs
' Язык: VBScript
' Описание: Определение роли компьютера в домене
'*******************************************************************
Option Explicit
 
' Объявляем переменные
Dim strComputer       ' Имя компьютера
Dim strNamespace      ' Имя пространства имен
Dim strClass          ' Имя класса 
Dim objClass          ' Объект SWbemObject (класс WMI)
Dim colInstances      ' Коллекция экземпляров класса WMI
Dim objInstance       ' Элемент коллекции
Dim strComputerRole   ' Роль компьютера в домене

'********************** Начало *************************************
' Присваиваем начальные значения переменным
strComputer = "."
strNamespace = "Root\CIMV2"
strClass = "Win32_ComputerSystem"

' Получаем указатель на класс WMI 
Set objClass = GetObject("WinMgmts:\\" & strComputer & _
                         "\" & strNamespace & ":" & strClass)
' Создаем коллекцию экземпляров класса Win32_ComputerSystem
Set colInstances = objClass.Instances_

' Перебираем элементы коллекции 
For Each objInstance In colInstances
    ' Выделяем описание роли компьюьера
    Select Case objInstance.DomainRole 
        Case 0 
            strComputerRole = "Standalone Workstation"
        Case 1        
            strComputerRole = "Member Workstation"
        Case 2
            strComputerRole = "Standalone Server"
        Case 3
            strComputerRole = "Member Server"
        Case 4
            strComputerRole = "Backup Domain Controller"
        Case 5
            strComputerRole = "Primary Domain Controller"
    End Select
    
    ' Выводим результат на экран
    Wscript.Echo "Роль компьютера " & strComputer & ": " & strComputerRole
Next
'************************* Конец ***********************************
