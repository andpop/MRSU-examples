set fso = CreateObject("Scripting.FileSystemObject")
dim errcount() ' объявление массива с динамическим изменением размера
max_names = 20 ' начальное резервирование места для 20 имен
redim errcount(2, max_names)
n_names = 0 ' пока имен в списке нет
set strm = fso.OpenTextFile("servers.txt")
do while not strm.AtEndOfStream ' сканирование всех записей в журнале
  servername = strm.ReadLine() ' получение имени сервера из записи журнала
                               ' с увеличением его счетчика ошибок
  for i = 1 to n_names ' имя уже есть в списке?
    if errcount(1,i) = servername then ' да, тогда просто
      errcount(2,i) = errcount(2,i)+1 ' увеличение его счетчика ошибок
      exit for
    end if
  next
  if i > n_names then ' не найдено, тогда добавить это имя
    if n_names = max_names then ' список полон, увеличит его размер
      max_names = max_names+20
      redim preserve errcount(2,max_names)
    end if
    n_names = n_names+1 ' добавление нового имени к списку
    errcount(1, n_names) = servername
    errcount(2, n_names) = 1 ' установка счетчика ошибок в 1
  end if
loop
strm.Close

' а теперь вывод списка счетчиков
wscript.echo "Сервер" & vbTab & "Количество ошибок "
for i = 1 to n_names
  wscript.echo errcount(1,i) & vbTab & cstr(errcount(2,i))
next
