//*******************************************************************
// Имя: Classes.js
// Язык: JScript
// Описание: Просмотр всех классов в пространстве имен
//*******************************************************************
// Объявляем переменные
var 
  strComputer,        // Имя компьютера
  strResult,          // Результат (текстовое сообщение) 
  strNamespace,       // Имя пространства имен
  WshShell,           // Объект WshShell
  objService,         // Объект SWbemServices
  colClasses,         // Коллекция классов
  objClass,           // Элемент коллекции
  theNotepad;         // Объект WshScriptExec

// Константа для задания режима открытия файла
var ForWriting = 2;

// Функция для записи информации в файл 
function TextOut (Text, File) {
  // Объявляем переменные
  var FSO, FOut ;
  // Создаем объект FileSystemObject
  FSO = WScript.CreateObject("Scripting.FileSystemObject");
  // Открываем выходной файл для записи
  FOut = FSO.OpenTextFile (File,ForWriting,true);
  // Записываем текстовую строку в файл
  FOut.WriteLine(Text);
  // Закрываем выходной файл
  FOut.Close();
}

//********************** Начало *************************************
// Присваиваем начальные значения переменным
strComputer = ".";
strResult = "";
strNamespace = "Root\\CIMV2";

// Подключаемся к пространству имен WMI
objService = GetObject("winmgmts:\\\\" + strComputer + "\\" + strNamespace);

// Создаем коллекцию классов WMI
colClasses = new Enumerator(objService.SubclassesOf());

// Перебираем элементы коллекции 
while (!colClasses.atEnd()) {
  //Извлекаем текущий элемент коллекции
  objClass = colClasses.item();
  //Формируем результирующую строку
  strResult += "  " + objClass.Path_.Class + "\r\n";
  //Переходим к следующему элементу коллекции
  colClasses.moveNext();
  }
// Выводим результат в файл с помощью функции TextOut
TextOut (" Список классов в пространстве имен  " + strNamespace +
         " : \r\n" + strResult, "C:\\Classes.txt"); 

// Создаем объект WshShell
WshShell = WScript.CreateObject("WScript.Shell");
// Открываем созданный файл в Блокноте
theNotepad = WshShell.Exec("notepad  C:\\Classes.txt" );
//************************* Конец ***********************************
