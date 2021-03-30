/*******************************************************************/
/* Имя: ExecConApp.js                                              */
/* Язык: JScript                                                   */
/* Описание: Запуск дочернего консольного приложения               */
/*******************************************************************/
//Объявляем переменные
var ObjExec,WshShell,s,IsBreak,ArrS,ColStr,ColFiles,i;
//Создаем объект WshShell
WshShell = WScript.CreateObject("WScript.Shell");
//Запускаем команду DIR
ObjExec=WshShell.Exec("%COMSPEC% /c dir /b");
s="";
IsBreak=false;
for (;;) {  //Бесконечный цикл
  //Проверяем, достигнут ли конец выходного потока команды DIR
  if (!ObjExec.StdOut.AtEndOfStream)
    //Считываем полностью выходной поток команды DIR
    s+=ObjExec.StdOut.ReadAll();
  if (IsBreak)
    break; //Выходим из цикла
  if (ObjExec.Status==1)  //Проверяем, не завершилось ли выполнение DIR
    IsBreak=true;
  else
    WScript.Sleep(100);  //Приостанавливаем сценарий на 0,1 сек
  }
ArrS=s.split("\n");  //Формируем массив строк
ColFiles=ArrS.length-1;   // Количество файлов в текущем каталоге
WScript.StdOut.WriteLine("Всего файлов в текущем каталоге: "+ColFiles);
for (i=0;i<=ColFiles-1;i++)
  WScript.StdOut.WriteLine(ArrS[i]); //Выводим строки на экран
/*************  Конец *********************************************/
