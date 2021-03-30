/*******************************************************************/
/* Имя: StdIn2.js                                                  */
/* Язык: JScript                                                   */
/* Описание: Пример использования метода StdIn.ReadAll             */
/*******************************************************************/
var RusDict;

//Функция для создания объекта Dictionary с парами "ключ-значение", где
//"ключ" - буква в DOS-кодировке,
//"значение" - символ, соответствующий этой букве в Windows-кодировке
function MakeRusDict() {
  //Создаем объект Dictionary
  RusDict = WScript.CreateObject("Scripting.Dictionary");
  //Заполняем пары "ключ" (символ в DOS-кодировке)- "значение" (символ в
  //Window-кодировке) для всех букв русского алфавита
  RusDict.add ("Ђ", "А"); RusDict.add ("Ѓ", "Б"); RusDict.add ("‚", "В");
  RusDict.add ("ѓ", "Г"); RusDict.add ("„", "Д"); RusDict.add ("…", "Е");
  RusDict.add ("р", "Ё"); RusDict.add ("†", "Ж"); RusDict.add ("‡", "З");
  RusDict.add ("€", "И"); RusDict.add ("‰", "Й"); RusDict.add ("Љ", "К");
  RusDict.add ("‹", "Л"); RusDict.add ("Њ", "М"); RusDict.add ("Ќ", "Н");
  RusDict.add ("Ћ", "О"); RusDict.add ("Џ", "П"); RusDict.add ("ђ", "Р");
  RusDict.add ("'", "С"); RusDict.add ("'", "Т"); RusDict.add (""", "У");
  RusDict.add (""", "Ф"); RusDict.add ("o", "Х"); RusDict.add ("-", "Ц");
  RusDict.add ("-", "Ч"); RusDict.add ("", "Ш"); RusDict.add ("™", "Щ");
  RusDict.add ("љ", "Ъ"); RusDict.add ("›", "Ы"); RusDict.add ("њ", "Ь");
  RusDict.add ("ќ", "Э"); RusDict.add ("ћ", "Ю"); RusDict.add ("џ", "Я");

  RusDict.add (" ", "а"); RusDict.add ("Ў", "б"); RusDict.add ("ў", "в");
  RusDict.add ("Ј", "г"); RusDict.add ("¤", "д"); RusDict.add ("Ґ", "е");
  RusDict.add ("с", "ё"); RusDict.add ("¦", "ж"); RusDict.add ("§", "з");
  RusDict.add ("Ё", "и"); RusDict.add ("©", "й"); RusDict.add ("Є", "к");
  RusDict.add (""", "л"); RusDict.add ("", "м"); RusDict.add ("­", "н");
  RusDict.add ("®", "о"); RusDict.add ("Ї", "п"); RusDict.add ("а", "р");
  RusDict.add ("б", "с"); RusDict.add ("в", "т"); RusDict.add ("г", "у");
  RusDict.add ("д", "ф"); RusDict.add ("е", "х"); RusDict.add ("ж", "ц");
  RusDict.add ("з", "ч"); RusDict.add ("и", "ш"); RusDict.add ("й", "щ");
  RusDict.add ("к", "ъ"); RusDict.add ("л", "ы"); RusDict.add ("м", "ь");
  RusDict.add ("н", "э"); RusDict.add ("о", "ю"); RusDict.add ("п", "я");
}

//Функция для перевода строки из DOS- в Windows-кодировку
function DosToWin(s) {
  var i,ss;  //Объявляем переменные
  //Проверяем, создан ли объект RusDict
  if (typeof(RusDict)=="undefined")
    //Если объект RusDict не создан, создаем его
    MakeRusDict();
  ss="";
  for (i=0;i<s.length;i++) {  //Цикл по всем символам в строке
    if (RusDict.Exists(s.charAt(i)))  //Проверяем наличие символа в словаре
      //Преобразуем i-й символ в Windows-кодировку
      ss+=RusDict.Item(s.charAt(i));
    else
      ss+=s.charAt(i);
    }
  return ss;
  }
/*************  Начало *********************************************/
var s,ArrS,i;  //Объявляем переменные
//Печатаем приглашение для ввода
WScript.StdOut.WriteLine("Вводите строки:");
s = WScript.StdIn.ReadAll();  //Вводим строки с клавиатуры
WScript.StdOut.WriteBlankLines(3);  //Печатаем пустые строки
ArrS=s.split("\n");  //Формируем массив из введенных строк
WScript.StdOut.WriteLine("Всего ведено строк: "+ArrS.length);
for (i=1;i<=ArrS.length;i++)
  //Преобразовываем введенные строки в Windows-кодировку
  //и выводим их на экран
  WScript.StdOut.WriteLine(i+": "+DosToWin(ArrS[i-1]));
/*************  Конец *********************************************/
