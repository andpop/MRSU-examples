'*******************************************************************
' Имя: ExecConApp.vbs
' Язык: VbScript
' Описание: Запуск дочернего консольного приложения
'*******************************************************************
Option Explicit
' Объявляем переменные
Dim ObjExec,WshShell,s,IsBreak,ArrS,ColStr,ColFiles,i
' Создаем объект WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
' Запускаем команду DIR
Set ObjExec=WshShell.Exec("%COMSPEC% /c dir /b")
s=""
IsBreak=False
Do While True  ' Бесконечный цикл
  ' Проверяем, достигнут ли конец выходного потока команды DIR
  If (Not ObjExec.StdOut.AtEndOfStream) Then
    ' Считываем полностью выходной поток команды DIR
    s=s+ObjExec.StdOut.ReadAll
  End If
  If IsBreak Then
    Exit Do  ' Выходим из цикла
  End If
  ' Проверяем, не завершилось ли выполнение DIR
  If ObjExec.Status=1 Then
    IsBreak=True
  Else
    WScript.Sleep 100 ' Приостанавливаем сценарий на 0,1 сек
  End If
Loop
ArrS=Split(s,vbCrLf)  ' Формируем массив строк
ColFiles=UBound(ArrS)  ' Количество файлов в текущем каталоге
WScript.StdOut.WriteLine "Всего файлов в текущем каталоге: " & ColFiles
For i=0 To ColFiles-1
  WScript.StdOut.WriteLine ArrS(i)  ' Выводим строки на экран
Next
'*************  Конец *********************************************
