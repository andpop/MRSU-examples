/*******************************************************************/
/* Имя: MakeFolder.js                                             */
/* Язык: JScript                                                   */
/* Описание: Создание нового каталога                              */
/*******************************************************************/
//Объявляем переменные
var FSO, F, SubFolders;

//Создаем объект FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//Создаем каталог C:\Program Files\Новая папка
FSO.CreateFolder("C:\\Program Files\\Новая папка");
//Создаем объект Folder для каталога C:\Program Files
F=FSO.GetFolder("C:\\Program Files");
//Создаем коллекцию подкаталогов каталога C:\Program Files
SubFolders=F.SubFolders;
//Создаем каталог C:\Program Files\Еще одна новая папка
SubFolders.Add("Еще одна новая папка");
/*************  Конец *********************************************/
