#!/bin/bash

#Выводим путь к текущему каталогу из переменной PWD
echo "Текущий каталог: $PWD"

#Выводим путь к текущему каталогу из переменной PWD
echo "Переменная MY_VAR: $MY_VAR"

#Выводим имя скрипта
echo "Имя скрипта: $0"

# Выводим количество аргументов
echo "Количество аргументов: $#"

# Выводим все аргументы
echo "Все аргументы:"
for arg in "$@"; do
  echo "- $arg"
done
