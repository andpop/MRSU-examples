/*******************************************************************/
/* Имя: DeleteFile.js                                              */
/* Язык: JScript                                                   */
/* Описание: Создание и удаление файла                             */
/*******************************************************************/
//Объявляем переменные
var FSO,F,FileName;

//Создаем объект FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//Задаем имя файла
FileName="C:\\TestFile.txt";
//Создаем файл
F=FSO.CreateTextFile(FileName, true);
//Записываем в файл строку
F.WriteLine("Тестовый файл");
//Закрываем файл
F.Close();
WScript.Echo("Файл создан");
FSO.DeleteFile(FileName);
WScript.Echo("Файл удален");
/*************  Конец *********************************************/
