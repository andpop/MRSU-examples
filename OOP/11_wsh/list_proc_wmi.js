/********************************************************************/
/* Имя: ListProcesses.js                                            */
/* Язык: JScript                                                    */
/* Описание: Вывод на экран списка всех запущенных на локальной     */
/*           рабочей станции процессов                              */
/********************************************************************/
var 
  WMI,                  //Экземпляр WMI
  Processes,            //Коллекция процессов
  Process,              //Экземпляр коллекции
  SList;                //Строка для вывода на экран

var vbCritical=16;

try  {
  //Соединяемся с WMI
  WMI=GetObject("winMgmts:");
  }
catch (e) {  //Обрабатываем возможные ошибки
  if (e != 0) {
    Mess="Ошибка при соединении с WMI";
    WshShell.Popup(Mess,0,"Запущенные процессы",vbCritical);
    WScript.Quit();
    }
  }

Processes=new Enumerator(WMI.ExecQuery("SELECT * FROM Win32_Process"));
SList="Запущенные процессы\n\n";

//Цикл по всем элементам коллекции
while (!Processes.atEnd()) {
  Process=Processes.item();
  SList+=Process.Name+"\n";
  Processes.moveNext();
  }

WScript.Echo(SList);

