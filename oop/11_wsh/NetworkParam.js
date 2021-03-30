/********************************************************************/
/* Имя: NetworkParam.js                                             */
/* Язык: JScript                                                    */
/* Описание: Вывод сетевых параметров станции                       */
/********************************************************************/
var WshNetwork,s; //Объявляем переменные

//Создаем объект WshNetwork
WshNetwork = WScript.CreateObject("WScript.Network");

s="Сетевые параметры станции:\n\n";
//Выводим на экран свойства ComputerName, UserName и UserDomain
s+="Имя машины: "+WshNetwork.ComputerName+"\n";
s+="Имя пользователя: "+WshNetwork.UserName+"\n";
s+="Домен: "+WshNetwork.UserDomain;
WScript.Echo(s);
/*************  Конец *********************************************/
