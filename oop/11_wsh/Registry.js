/********************************************************************/
/* Имя: Registry.js                                                 */
/* Язык: JScript                                                    */
/* Описание: Работа с системным реестром                            */
/********************************************************************/
//Объявляем переменные
var WshShell,Root,Key,Res,SValue,ValueName,SRegValue;
//Инициализируем константы для диалоговых окон
var vbYesNo=4,vbQuestion=32,vbInformation=64,vbYes=6,vbOkOnly=0;

Root="HKEY_CURRENT_USER";  //Корневой ключ
Key="\\ExampleKey\\";      //Новый ключ
ValueName="ExampleValue";  //Имя нового параметра
SValue="Value from WSH";   //Значение нового параметра

//Создаем объект WshShell
WshShell=WScript.CreateObject("WScript.Shell");

//Запрос на создание нового ключа
Res=WshShell.Popup("Создать ключ\n"+Root+Key+"?",0,
  "Работа с реестром",vbQuestion+vbYesNo);
if (Res==vbYes) { //Нажата кнопка Да
  //Записываем новый ключ
  WshShell.RegWrite(Root+Key,"");
  WshShell.Popup("Ключ\n"+Root+Key+" создан!",0,
    "Работа с реестром",vbInformation+vbOkOnly);
  }

//Запрос на запись нового параметра
Res=WshShell.Popup("Записать параметр\n"+Root+Key+ValueName+"?",0,
  "Работа с реестром",vbQuestion+vbYesNo);
if (Res==vbYes) { //Нажата кнопка Да
  //Записываем новый строковый параметр
  WshShell.RegWrite(Root+Key+ValueName,SValue,"REG_SZ");
  WshShell.Popup("Параметр\n"+Root+Key+ValueName+" записан!",0,
    "Работа с реестром",vbInformation+vbOkOnly);
  //Считываем значение созданного параметра
  SRegValue=WshShell.RegRead(Root+Key+ValueName);
  //Выводим на экран полученное значение
  WshShell.Popup(Root+Key+ValueName+"="+SRegValue,0,
    "Работа с реестром",vbInformation+vbOkOnly);
  }

//Запрос на удаление параметра
Res=WshShell.Popup("Удалить параметр\n"+Root+Key+ValueName+"?",0,
  "Работа с реестром",vbQuestion+vbYesNo);
if (Res==vbYes) { //Нажата кнопка Да
  //Удаляем параметр
  WshShell.RegDelete(Root+Key+ValueName);
  WshShell.Popup("Параметр\n"+Root+Key+ValueName+" удален!",0,
    "Работа с реестром",vbInformation+vbOkOnly);
  }

//Запрос на удаление раздела
Res=WshShell.Popup("Удалить раздел\n"+Root+Key+"?",0,
  "Работа с реестром",vbQuestion+vbYesNo);
if (Res==vbYes) {  //Нажата кнопка Да
  //Удаляем раздел
  WshShell.RegDelete(Root+Key);
  WshShell.Popup("Раздел\n"+Root+Key+" удален!",0,
    "Работа с реестром",vbInformation+vbOkOnly);
  }
/*************  Конец *********************************************/
