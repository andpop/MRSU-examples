-- Подзапрос внутри THEN ...
SELECT v.name,
   CASE
      WHEN v.city='Саранск' THEN
         (SELECT count(*) from `order` o
          WHERE v.id=o.vendor_id)
      ELSE
         'Не из Саранска'
   END sales
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

-- 14. Window functions
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


SELECT id, summa, lag(summa, 1) OVER () 'Предыдущая сумма',
lead(summa, 1) OVER () 'Следующая сумма' FROM `order`;

--------------------------------------------------------------------
-- Дублирование данных из таблицы `order` под новой датой
insert into `order` (summa, order_date, customer_id, vendor_id) select summa, '2021-09-25', customer_id, vendor_id from `order`;

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


WITH RECURSIVE dates(x) AS (
   SELECT '2021-01-01'
      UNION ALL
   SELECT DATE(x, '+1 day') FROM dates WHERE x<'2021-12-31')
SELECT * FROM dates;

------------------------------------------
WITH RECURSIVE ten(x, y) AS (
   SELECT 1, 1
      UNION ALL
   SELECT x+1, y*2 FROM ten WHERE x<10)
SELECT * FROM ten;

WITH RECURSIVE ten(x) AS (
   SELECT 1
      UNION
   SELECT 5
      UNION ALL
   SELECT x+1 FROM ten WHERE x<5)
SELECT * FROM ten;

WITH temp (n, fact) AS
(SELECT 0, 1
  UNION ALL
 SELECT n+1, (n+1)*fact FROM temp
        WHERE n < 9)
SELECT * FROM temp;

The basic algorithm for computing the content of the recursive table is as follows:

1. Run the initial-select and add the results to a queue.
2. While the queue is not empty:
   a. Extract a single row from the queue.
   b. Insert that single row into the recursive table
   c. Pretend that the single row just extracted is the only row in the recursive table and run the recursive-select, adding all results to the queue.

The basic procedure above may modified by the following additional rules:

* If a UNION operator connects the initial-select with the recursive-select, then only add rows to the queue if no identical row has been previously added to the queue. Repeated rows are discarded before being added to the queue even if the repeated rows have already been extracted from the queue by the recursion step. If the operator is UNION ALL, then all rows generated by both the initial-select and the recursive-select are always added to the queue even if they are repeats. When determining if a row is repeated, NULL values compare equal to one another and not equal to any other value.
* The LIMIT clause, if present, determines the maximum number of rows that will ever be added to the recursive table in step 2b. Once the limit is reached, the recursion stops. A limit of zero means that no rows are ever added to the recursive table, and a negative limit means an unlimited number of rows may be added to the recursive table.
* The OFFSET clause, if it is present and has a positive value N, prevents the first N rows from being added to the recursive table. The first N rows are still processed by the recursive-select — they just are not added to the recursive table. Rows are not counted toward fulfilling the LIMIT until all OFFSET rows have been skipped.
* If an ORDER BY clause is present, it determines the order in which rows are extracted from the queue in step 2a. If there is no ORDER BY clause, then the order in which rows are extracted is undefined. (In the current implementation, the queue becomes a FIFO if the ORDER BY clause is omitted, but applications should not depend on that fact since it might change.)
