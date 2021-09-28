========== Условная логика ==================
-- Подзапрос внутри THEN ...
SELECT id, name 'Покупатель',
   CASE
      WHEN rating>=300 THEN 'Молодец'
      WHEN rating>=200 THEN 'Неплохо'
      ELSE 'Старайся'
   END 'Рейтинг'
FROM customer;

SELECT v.name 'Продавец',
   CASE
      WHEN v.city='Саранск' THEN
         (SELECT count(*) from `order` o
          WHERE v.id=o.vendor_id)
      ELSE
         'Не из Саранска'
   END 'Земляк'
FROM vendor v;

-- Защита от деления на ноль
SELECT v.name 'Продавец', sum(o.summa) 'Сумма', count(o.summa) 'Количество',
   sum(o.summa) /
   CASE WHEN count(o.summa) = 0 THEN 1
       ELSE count(o.summa)
   END 'Средний чек'
FROM vendor v
   LEFT OUTER JOIN `order` o
   ON v.id=o.vendor_id
GROUP BY v.name;

=========== Аналитические функции ==============

SELECT *, ROW_NUMBER() OVER () AS number FROM customer;

-- Функции ранжирования
SELECT *, ROW_NUMBER() OVER (ORDER BY rating DESC) AS rating_place FROM customer ORDER BY name;

SELECT *, RANK() OVER (ORDER BY rating DESC) AS rank FROM customer ORDER BY name;

SELECT *, DENSE_RANK() OVER (ORDER BY rating DESC) AS rank FROM customer ORDER BY name;

SELECT id, name, rating, ROW_NUMBER() OVER (ORDER BY rating DESC) AS row_number,
RANK() OVER (ORDER BY rating DESC) AS rank, DENSE_RANK() OVER (ORDER BY rating DESC) AS dense_rank FROM customer ORDER BY name;

-- Ранжирование по суммам заказов по годам
SELECT *, RANK() OVER (PARTITION BY strftime('%Y', order_date) ORDER BY summa DESC) AS rank FROM `order` ORDER BY order_date;

-- Функции агрегирования
SELECT name, city, rating, AVG(rating) OVER () AS average_rating FROM customer;
SELECT name, city, rating, rating-AVG(rating) OVER () AS delta_rating FROM customer;

-- Возвращается одна строка
SELECT *, MAX(rating) FROM customer;
-- Возвращаются все строки
SELECT *, MAX(rating) OVER () FROM customer;

SELECT *, COUNT(*) OVER (PARTITION BY city) AS customers_in_city FROM customer;

-- Рамки окон
-- Окно данных от начала результирующего набора до текущей строки, включая ее
SELECT *, sum(summa) OVER (ROWS UNBOUNDED PRECEDING) 'Нарастающий итог' FROM `order`;


SELECT id, summa, lag(summa, 2) OVER () 'Предыдущая сумма',
lead(summa, 1) OVER () 'Следующая сумма' FROM `order`;

--------------------------------------------------------------------
-- Дублирование данных из таблицы `order` под новой датой
insert into `order` (summa, order_date, customer_id, vendor_id) select summa, '2021-09-28', customer_id, vendor_id from `order` where order_date='2016-12-10';

===== Объединение результатов запросов ===========================
--------------------------------------------------------------------
-- UNION и UNION ALL
SELECT 1,2
UNION
SELECT 1,2
UNION
SELECT 3,4;

SELECT 1,2
UNION ALL
SELECT 1,2
UNION ALL
SELECT 3,4;

======= Представления =========================
CREATE VIEW orders_with_names
AS SELECT `order`.order_date, customer.name AS customer_name, vendor.name AS vendor_name, `order`.summa
FROM `order`, customer, vendor
WHERE `order`.customer_id = customer.id AND `order`.vendor_id = vendor.id;

SELECT * FROM orders_with_names;

======= Обобщенные табличные выражения ==========
---------------------------------------------------------------------
-- Common table expressions

-- Запрос с подзапросом
SELECT * 
FROM (SELECT 1);

-- Запрос с CTE
WITH one AS (SELECT 1)
SELECT * FROM one;

-- Можно указать имена столбцов в CTE
WITH twoColumns(a,b) AS (SELECT 1, 2)
SELECT * FROM twoColumns;


WITH customer_saransk AS
   (SELECT id, name
    FROM customer 
    WHERE city="Саранск"),
order_saransk AS
   (SELECT c.name, o.order_date, o.summa
    FROM `order` o
       INNER JOIN customer_saransk c
       ON o.customer_id=c.id)
SELECT *
FROM order_saransk
ORDER BY name;


WITH RECURSIVE infinite AS (
   SELECT 1
      UNION ALL
   SELECT * FROM infinite)
SELECT * FROM infinite;

WITH RECURSIVE finite AS (
   SELECT 1
      UNION ALL
   SELECT * FROM finite LIMIT 2)
SELECT * FROM finite;

WITH RECURSIVE ten(x) AS (
   SELECT 1
      UNION ALL
   SELECT x+1 FROM ten WHERE x<10)
SELECT * FROM ten;

WITH RECURSIVE ten AS (
   SELECT 1 x
      UNION ALL
   SELECT x+1 FROM ten WHERE x<10)
SELECT * FROM ten;


---------------------------------------------------------------------
WITH RECURSIVE dates(x) AS (
   SELECT '2021-01-01'
      UNION ALL
   SELECT DATE(x, '+1 day') FROM dates WHERE x<'2021-12-31')
SELECT * FROM dates;

SELECT date('2021-01-01', '+'||(ones.num + tens.num + hundreds.num)||' days') dt
FROM
(SELECT 0 num UNION
SELECT 1 num UNION
SELECT 2 num UNION
SELECT 3 num UNION
SELECT 4 num UNION
SELECT 5 num UNION
SELECT 6 num UNION
SELECT 7 num UNION
SELECT 8 num UNION
SELECT 9 num) ones
CROSS JOIN
(SELECT 0 num UNION
SELECT 10 num UNION
SELECT 20 num UNION
SELECT 30 num UNION
SELECT 40 num UNION
SELECT 50 num UNION
SELECT 60 num UNION
SELECT 70 num UNION
SELECT 80 num UNION
SELECT 90 num) tens
CROSS JOIN
(SELECT 100 num UNION
SELECT 200 num UNION
SELECT 300 num) hundreds
WHERE dt < '2022-01-01'
ORDER BY 1;
------------------------------------------
WITH RECURSIVE ten(x, y) AS (
   SELECT 1, 1
      UNION ALL
   SELECT x+1, y*2 FROM ten WHERE x<10)
SELECT * FROM ten;

WITH temp (n, fact) AS
(SELECT 0, 1
  UNION ALL
 SELECT n+1, (n+1)*fact FROM temp WHERE n < 9)
SELECT * FROM temp;

