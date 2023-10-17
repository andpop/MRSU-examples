.mode box
-- Импорт данных из CSV-файла
.import --csv ./dataset/city.csv city
.schema city

select federal_district, city, population from city limit 10;

select
  federal_district as district,
  count(*) as city_count
from city
group by federal_district
order by city_count desc;

-- Экспорт данных в CSV-файл (только нужные столбцы)
.once mordovia.csv
select kladr_id, city from city where region = 'Мордовия';

-- Если нужно выгружать данные с заголовками столбцов в первой строке
.header on

-- Замена разделителей между столбцами
.separator ;

-- Убрать кавычки при выводе
.mode list

-- Выгрузка в JSON
.mode json

-- Другие форматы выгрузки
.mode markdown
.mode html
