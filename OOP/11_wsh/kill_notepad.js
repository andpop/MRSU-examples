/********************************************************************/
/* Имя: KillNotepads.js                                             */
/* Язык: JScript                                                    */
/* Описание: Закрытие всех запущенных экземпляров Блокнота          */
/********************************************************************/
var
  WMI,                  //Экземпляр WMI
  SQuery,               //Текст запроса
  Processes,            //Коллекция процессов
  Process,              //Экземпляр коллекции
  WshShell;             //Объект WshShell
//Инициализируем константы для диалоговых окон
var vbCritical=16;

//Создаем объект WshShell
WshShell = WScript.CreateObject("WScript.Shell");
    
try  {
  //Соединяемся с WMI
  WMI=GetObject("winMgmts:");
  }
catch (e) {  //Обрабатываем возможные ошибки
  if (e != 0) {
    //Выводим сообщение об ошибке
    Mess="Ошибка при соединении с WMI";
    WshShell.Popup(Mess,0,"Закрытие всех Блокнотов",vbCritical);
    //Выходим из сценария
    WScript.Quit();
    }
  }
  
//Формируем текст запроса  
SQuery="SELECT * FROM Win32_Process WHERE Name='Notepad.exe'"
//Создаем коллекцию-результат запроса
Processes=new Enumerator(WMI.ExecQuery(SQuery));

//Цикл по всем элементам коллекции
while (!Processes.atEnd()) {
  //Извлекаем текущий элемент коллекции (процесс с именем Notepad.exe)
  Process=Processes.item();
  try  {  
    //Завершаем процесс
    Process.Terminate();
    }
  catch (e) {  //Обрабатываем возможные ошибки
    if (e != 0) {
      //Выводим сообщение об ошибке
      Mess="Ошибка при закрытии текущего экземпляра";
      WshShell.Popup(Mess,0,"Закрытие всех Блокнотов",vbCritical);
      }
    }
  //Переходим к следующему элементу коллекции  
  Processes.moveNext();
  }

