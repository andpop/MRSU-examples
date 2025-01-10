/*****************************************************************/
/* Имя: Shortcut.js                                              */
/* Язык: JScript                                                 */
/* Описание: Создание ярлыков в специальных папках               */
/*****************************************************************/
//Объявляем переменные
var WshShell,MyShortcut,PathTarg,PathIcon,Res,PathShortcut;
//Инициализируем константы для диалоговых окон
var vbYesNo=4,vbQuestion=32,vbYes=6;

//Создаем объект WshShell
WshShell = WScript.CreateObject("WScript.Shell");
//Выводим запрос для выбора папки, в которой будет создан ярлык
Res=WshShell.Popup("Где создать ярлык?\nДа  - на рабочем столе\nНет - в меню Программы",0,
  "Работа с ярлыками",vbQuestion+vbYesNo);
if (Res==vbYes) //Нажата кнопка Да
  //Определяем путь к рабочему столу
  PathShortcut = WshShell.SpecialFolders("Desktop");
else
  //Определяем путь к меню Программы
  PathShortcut = WshShell.SpecialFolders("Programs");
//Создаем объект-ярлык
MyShortcut = WshShell.CreateShortcut(PathShortcut+"\\Мой ярлык.lnk");
//Устанавливаем путь к файлу
PathTarg=WshShell.ExpandEnvironmentStrings("%windir%\\notepad.exe");
MyShortcut.TargetPath = PathTarg;
//Назначаем комбинацию горячих клавиш
MyShortcut.Hotkey = "CTRL+ALT+N";
//Выбираем значок из файла SHELL32.dll
PathIcon=
  WshShell.ExpandEnvironmentStrings("%windir%\\system32\\SHELL32.dll");
MyShortcut.IconLocation = PathIcon+", 1";
MyShortcut.WindowStyle=3;   //Устанавливаем тип окна (максимизировано)
MyShortcut.Save();  //Сохраняем ярлык
WScript.Echo("Ярлык создан|");
/*************  Конец *********************************************/
