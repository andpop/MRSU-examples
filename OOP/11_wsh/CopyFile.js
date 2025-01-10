/*******************************************************************/
/* Имя: CopyFile.js                                                */
/* Язык: JScript                                                   */
/* Описание: Создание и копирование файла                          */
/*******************************************************************/
//Объявляем переменные
var FSO,F,WshShell,WshFldrs,PathCopy;

//Создаем объект FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//Создаем файл
F=FSO.CreateTextFile("C:\\TestFile.txt", true);
//Записываем в файл строку
F.WriteLine("Тестовый файл");
//Закрываем файл
F.Close();

//Создаем объект WshShell
WshShell=WScript.CreateObject("Wscript.Shell");
//Создаем объект WshSpecialFolders
WshFldrs=WshShell.SpecialFolders;
//Определяем путь к рабочему столу
PathCopy=WshFldrs.item("Desktop")+"\\";
//Создаем объект File для файла C:\TestFile.txt
F=FSO.GetFile("C:\\TestFile.txt");
//Копируем файл на рабочий стол
F.Copy(PathCopy);
/*************  Конец *********************************************/
