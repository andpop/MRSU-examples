'*******************************************************************
' Имя: ExecWinApp.vbs
' Язык: VBScript
' Описание: Запуск и закрытие приложение (объект WshScriptExec)
'*******************************************************************
Option Explicit

Dim WshShell,theNotepad,Res,Text,Title   ' Объявляем переменные
' Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
WScript.Echo "Запускаем Блокнот"
' Запускаем приложение (создаем объект WshScriptExec)
Set theNotepad = WshShell.Exec("notepad")
WScript.Sleep 500   ' Приостанавливаем выполнение сценария
Text="Блокнот запущен (Status=" & theNotepad.Status & ")" & vbCrLf _
      & "Закрыть Блокнот?"
Title=""
' Выводим диалоговое окно на экран
Res=WshShell.Popup(Text,0,Title,vbQuestion+vbYesNo)
' Определяем, какая кнопка нажата в диалоговом окне
If Res=vbYes Then
  theNotepad.Terminate ' Прерываем работу Блокнота
  ' Приостанавливаем выполнение сценария для того, чтобы Блокнот
  ' успел закрыться
  WScript.Sleep 100
  WScript.Echo "Блокнот закрыт (Status=" & theNotepad.Status & ")"
End If
'*************  Конец *********************************************
