/*******************************************************************/
/* Имя: ListFiles.js                                               */
/* Язык: JScript                                                   */
/* Описание: Получение списка всех файлов заданного каталога       */
/*******************************************************************/
//Объявляем переменные
var FSO,F,Files,WshShell,PathList,s;

//Создаем объект FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");

//Создаем объект WshShell
WshShell=WScript.CreateObject("Wscript.Shell");
//Создаем объект WshSpecialFolders
WshFldrs=WshShell.SpecialFolders;
//Определяем путь к папке "Мои документы"
PathList=WshFldrs.item("MyDocuments")+"\\";

//Создаем объект Folder для папки "Мои документы"
F=FSO.GetFolder(PathList);
//Создаем коллекцию файлов каталога "Мои документы"
Files=new Enumerator(F.Files);
s = "Файлы из каталога "+PathList+"\n";
//Цикл по всем файлам
for (; !Files.atEnd(); Files.moveNext()) 
  //Добавляем строку с именем файла
  s+=Files.item().Name+"\n";
//Выводим полученные строки на экран
WScript.Echo(s);
/*************  Конец *********************************************/
