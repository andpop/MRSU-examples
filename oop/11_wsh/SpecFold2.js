/******************************************************************/
/* Имя: SpecFold2.js                                              */
/* Язык: JScript                                                  */
/* Описание: Вывод названий заданных специальных папок Windows    */
/******************************************************************/
var WshShell, WshFldrs, s;   //Объявляем переменные
//Создаем объект WshShell
WshShell = WScript.CreateObject("Wscript.Shell");
//Создаем объект WshSpecialFolders
WshFldrs = WshShell.SpecialFolders;
//Формируем строки с путями к конкретным специальным папкам
s="Некоторые специальные папки:\n\n";
s+="Desktop:\t"+WshFldrs("Desktop")+"\n";
s+="Favorites:\t"+WshFldrs("Favorites")+"\n";
s+="Programs:\t"+WshFldrs("Programs");
WScript.Echo(s);  //Выводим сформированные строки на экран
/*************  Конец *********************************************/
