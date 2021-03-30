/*******************************************************************/
/* Имя: ExecWinApp.js                                              */
/* Язык: JScript                                                   */
/* Описание: Запуск и закрытие приложения (объект WshScriptExec)   */
/*******************************************************************/
var WshShell,theNotepad,Res,Text,Title;  //Объявляем переменные
//Инициализируем константы для диалоговых окон
var vbYesNo=4,vbQuestion=32,vbYes=6,vbNo=7;

//Создаем объект WshShell
WshShell = WScript.CreateObject("WScript.Shell");
WScript.Echo("Запускаем Блокнот");
//Запускаем приложение (создаем объект WshScriptExec)
theNotepad = WshShell.Exec("notepad");
WScript.Sleep(1000);  //Приостанавливаем выполнение сценария
Text="Блокнот запущен (Status="+theNotepad.Status+")\nЗакрыть Блокнот?";
Title="";
//Выводим диалоговое окно на экран
Res=WshShell.Popup(Text,0,Title,vbQuestion+vbYesNo);
//Определяем, какая кнопка нажата в диалоговом окне
if (Res==vbYes) {
  theNotepad.Terminate();  //Прерываем работу Блокнота
  //Приостанавливаем выполнение сценария для того, чтобы Блокнот
  //успел закрыться
  WScript.Sleep(100);
  WScript.Echo("Блокнот закрыт (Status="+theNotepad.Status+")");
  }
/*************  Конец *********************************************/
