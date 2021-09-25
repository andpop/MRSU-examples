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

