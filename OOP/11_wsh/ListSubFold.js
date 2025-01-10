/*******************************************************************/
/* Имя: ListSubFold.js                                             */
/* Язык: JScript                                                   */
/* Описание: Получение списка всех подкаталогов заданного каталога */
/*******************************************************************/
//Объявляем переменные
var FSO,F,SFold,SubFolders,s;

//Создаем объект FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//Путь к каталогу
SFold="C:\\Program Files";
s="Каталог "+SFold+"\n";
s+="Подкаталоги:\n";
//Создаем объект Folder для каталога C:\Program Files
F=FSO.GetFolder(SFold);
//Создаем коллекцию подкаталогов каталога C:\Program Files
SubFolders= new Enumerator(F.SubFolders);
//Цикл по всем подкаталогам
for (; !SubFolders.atEnd(); SubFolders.moveNext()) {
  s+=SubFolders.item()+"\n";  //Добавляем строку с именем подкаталога
  }
//Выводим полученные строки на экран
WScript.Echo(s);
/*************  Конец *********************************************/
