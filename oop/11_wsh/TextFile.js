/*******************************************************************/
/* Имя: TextFile.js                                                */
/* Язык: JScript                                                   */
/* Описание: Запись строк в текстовый файл и чтение из него        */
/*******************************************************************/
var FSO,F,TextStream,s;  //Объявляем переменные
//Инициализируем константы
var ForReading = 1, 
    ForWriting = 2, 
    TristateUseDefault = -2;

//Создаем объект FileSystemObject
FSO=WScript.CreateObject("Scripting.FileSystemObject");
//Создаем в текущем каталоге файл test1.txt
FSO.CreateTextFile("test1.txt"); 
//Создаем объект File для файла test1.txt
F=FSO.GetFile("test1.txt");
//Создаем объект TextStream (файл открывается для записи)
TextStream=F.OpenAsTextStream(ForWriting, TristateUseDefault);
//Записываем в файл строку
TextStream.WriteLine("Это первая строка");
//Закрываем файл
TextStream.Close();
//Открываем файл для чтения
TextStream=F.OpenAsTextStream(ForReading, TristateUseDefault);
//Считываем строку из файла
s=TextStream.ReadLine();
//Закрываем файл 
TextStream.Close();
//Отображаем строку на экране
WScript.Echo("Первая строка из файла test1.txt:\n\n",s);
/*************  Конец *********************************************/
