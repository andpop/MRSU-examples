'*******************************************************************
' Имя: StdIn2.vbs
' Язык: VBScript
' Описание: Пример использования метода StdIn.ReadAll
'*******************************************************************
Option Explicit
' Функция для перевода строки из DOS- в Windows-кодировку
Function DosToWin(s)
Dim i,k,ss
  ss=""
  For i=1 To Len(s)  ' Цикл по всем символам в строке
    k = Asc(Mid(s,i,1))  ' Определяем ANSI-код i-го символа
    ' Изменяем код k на код соответствующего символа в
    ' Windows-кодировке
    If (128 <= k) And (k <= 175) Then
      k=k+64
    ElseIf (224 <= k) And (k <= 239) Then
      k=k+16
    ElseIf k = 240 Then
      k=168
    ElseIf k = 241 Then
      k=184
    End If
    ss=ss+Chr(k)
  Next
  DosToWin=ss   ' Возвращаем преобразованную строку
End Function

'*************  Начало *********************************************
Dim s,ArrS,i,ColStr   ' Объявляем переменные
' Печатаем приглашение для ввода
WScript.StdOut.WriteLine "Вводите строки:"
s = WScript.StdIn.ReadAll  ' Вводим строки с клавиатуры
WScript.StdOut.WriteBlankLines 3  ' Печатаем пустые строки
ArrS=Split(s,vbCrLf)  ' Формируем массив из введенных строк
ColStr=UBound(ArrS)+1
' Печатаем введенные строки
WScript.StdOut.WriteLine "Всего ведено строк: " & ColStr
For i=1 To ColStr
  ' Преобразовываем введенные строки в Windows-кодировку
  ' и выводим их на экран
  WScript.StdOut.WriteLine i & ": " & DosToWin(ArrS(i-1))
Next
'*************  Конец *********************************************/
