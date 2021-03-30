$errcount = @{} # Создание пустой хэш-таблицы

# получение строк из файла и подсчет
get-content '.\servers.txt' | foreach {$errcount[$_]++}

$errcount | Sort-Object Name
