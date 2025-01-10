/********************************************************************/
/* Имя: MapResources.js                                             */
/* Язык: JScript                                                    */
/* Описание: Отключение и подключение сетевых дисков и принтеров    */
/********************************************************************/
//Объявляем переменные
var WshNetwork,WshShell,Drive,NetPath,Port,NetPrinter,Mess,IsError;
//Инициализируем константы для диалоговых окон
var vbCritical=16,vbInformation=64;

Drive="K:";      //Буква диска
NetPath="\\\\RS_NT_Server\\d";  //Сетевой путь для подключения диска
Port="LPT1";   //Название локального порта
//Сетевой путь для подключения принтера
NetPrinter="\\\\104_Stepankova\\HP";

//Создаем объект WshNetwork
WshNetwork = WScript.CreateObject("WScript.Network");
//Создаем объект WshShell
WshShell = WScript.CreateObject("WScript.Shell");

/*************  Отключение сетевого диска  ***********************/
IsError=false;
try  {
  //Отключаем сетевой диск
  WshNetwork.RemoveNetworkDrive(Drive);
  }
catch (e) {  //Обрабатываем возможные ошибки
  if (e != 0) {
    //Выводим сообщение об ошибке
    IsError=true;
    Mess="Ошибка при отключении диска "+Drive+"\nКод ошибки: "+
         e.number+"\nОписание: "+e.description;
    WshShell.Popup(Mess,0,"Отключение сетевого диска",vbCritical);
    }
  }
if (!IsError)  {
  //Все в порядке
  Mess="Диск "+Drive+" отключен успешно";
  WshShell.Popup(Mess,0,"Отключение сетевого диска",vbInformation);
  }

/*************  Подключение сетевого диска  ***********************/
IsError=false;
try  {
  //Подключаем сетевой диск
  WshNetwork.MapNetworkDrive(Drive,NetPath);
  }
catch (e) {  //Обрабатываем возможные ошибки
  if (e != 0) {
    //Выводим сообщение об ошибке
    IsError=true;
    Mess="Ошибка при подключении диска " + Drive + " к " + NetPath+
         "\nКод ошибки: "+e.number+"\nОписание: "+e.description;
    WshShell.Popup(Mess,0,"Подключение сетевого диска",vbCritical);
    }
  }
if (!IsError)  {
  //Все в порядке
  Mess="Диск "+Drive+" успешно подключен к "+NetPath;
  WshShell.Popup(Mess,0,"Подключение сетевого диска",vbInformation);
  }

/*************  Освобождение локального порта  ***********************/
IsError=false;
try  {
  //Разрываем связь с сетевым принтером
  WshNetwork.RemovePrinterConnection(Port);
  }
catch (e) {
  if (e != 0) {  //Обрабатываем возможные ошибки
    //Выводим сообщение об ошибке
    IsError=true;
    Mess="Ошибка при отключении порта "+Port+"\nКод ошибки: "+
         e.number+"\nОписание: "+e.description;
    WshShell.Popup(Mess,0,"Отключение локального порта от сетевого ресурса",vbCritical);
    }
  }
if (!IsError)  {
  //Все в порядке
  Mess="Порт "+Port+" отключен успешно";
  WshShell.Popup(Mess,0,"Отключение локального порта от сетевого ресурса",vbInformation);
  }

/*****  Подключение локального порта  к сетевому принтеру  *********/
IsError=false;
try  {
  //Подключаем сетевой принтер к локальному порту
  WshNetwork.AddPrinterConnection(Port,NetPrinter);
  }
catch (e) {  //Обрабатываем возможные ошибки
  if (e != 0) {
    //Выводим сообщение об ошибке
    IsError=true;
    Mess="Ошибка при переназначении порта "+Port+ " на "+NetPrinter+
                  "\nКод ошибки: "+e.number+"\nОписание: "+e.description;
    WshShell.Popup(Mess,0,"Подключение локального порта к сетевому ресурсу",vbCritical);
    }
  }
if (!IsError)  {
  //Все в порядке
  Mess="Порт "+Port+" успешно подключен к "+NetPrinter;
  WshShell.Popup(Mess,0,"Подключение локального порта к сетевому ресурсу",vbInformation);
  }
/*************  Конец *********************************************/
