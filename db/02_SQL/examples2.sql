
-- 2. Create tables
----- SQLite ---------------------
CREATE TABLE `vendor` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `percent` INTEGER NOT NULL CHECK (`percent`>0)
);

CREATE TABLE `customer` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `rating` INT(6) NOT NULL CHECK (`rating`>0),
  `vendor_id` INT(6) NULL
);

CREATE TABLE `order` (
  `id` INTEGER PRIMARY KEY,
  `summa` NUMERIC NOT NULL,
  `order_date` DATE NOT NULL,
  `customer_id` INTEGER NOT NULL,
  `vendor_id` INTEGER NOT NULL
);

-- 4. Relations and restrictions

----- SQLite  ---------------------
PRAGMA foreign_keys = ON;

DROP TABLE `order`;
DROP TABLE `customer`;


CREATE TABLE `order` (
  `id` INTEGER PRIMARY KEY,
  `summa` NUMERIC NOT NULL,
  `order_date` DATE NOT NULL,
  `customer_id` INTEGER NOT NULL,
  `vendor_id` INTEGER NOT NULL,
  FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE RESTRICT
);


CREATE TABLE `customer` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `rating` INTEGER NOT NULL CHECK (`rating`>0),
  `vendor_id` INTEGER NULL,
  FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) 
  ON DELETE SET NULL
);

CREATE TABLE `customer` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `rating` INTEGER NOT NULL CHECK (`rating`>0),
  `vendor_id` INTEGER NULL,
  FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) 
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE `customer` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `rating` INTEGER NOT NULL CHECK (`rating`>0),
  `vendor_id` INT(6) NULL,
  FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) 
  ON DELETE SET NULL
  ON UPDATE SET NULL
);

-- 3. Insert rows
INSERT INTO `vendor` (`id`, `name`, `city`, `percent`) VALUES
(1001, 'Иванов', 'Саранск', 12),
(1002, 'Петров', 'Москва', 13),
(1003, 'Андреев', 'Кострома', 10),
(1004, 'Сидоров', 'Саранск', 10);

INSERT INTO `customer` (`id`, `name`, `city`, `rating`, `vendor_id`) VALUES
(2001, 'Потапов', 'Саранск', 100, 1001),
(2002, 'Гарин', 'Владимир', 200, 1003),
(2003, 'Ли', 'Москва', 200, 1002),
(2004, 'Глухов', 'Самара', 300, 1002),
(2005, 'Клюев', 'Саранск', 100, 1001);

INSERT INTO `order` (`id`, `summa`, `order_date`, `customer_id`, `vendor_id`) VALUES
(3001, 18.69, '2016-12-10', 2005, 1001),
(3002, 767.19, '2016-12-10', 2001, 1001),
(3003, 1900.1, '2016-12-10', 2002, 1003),
(3004, 123.45, '2016-12-15', 2003, 1002),
(3005, 100, '2016-12-16', 2004, 1002),
(3006, 95.13, '2016-12-15', 2001, 1001);

===================================================================================
-- 8. Inner join
SELECT customer.name, vendor.name, vendor.city FROM vendor, customer WHERE vendor.city=customer.city;
SELECT customer.name, vendor.name, vendor.city FROM vendor INNER JOIN customer ON vendor.city=customer.city;

-- Inner join with three tables
SELECT customer.name 'Покупатель', vendor.name 'Продавец', vendor.city, `order`.order_date, `order`.summa
FROM vendor 
   INNER JOIN customer 
      ON vendor.city=customer.city
   INNER JOIN `order`
      ON `order`.customer_id=customer.id;

-- Поменяем порядок соединения таблиц. Изменится ли результат запроса?
SELECT customer.name 'Покупатель', vendor.name 'Продавец', vendor.city, `order`.order_date, `order`.summa
FROM `order`
   INNER JOIN customer
      ON `order`.customer_id=customer.id
   INNER JOIN vendor 
      ON vendor.city=customer.city;

--------------------------------------------------
-- Join with subquery result
SELECT cust_ord.name 'Покупатель', vendor.name 'Продавец', vendor.city, cust_ord.order_date, cust_ord.summa
FROM vendor 
   INNER JOIN 
   (SELECT customer.city, customer.name, `order`.order_date, `order`.summa
    FROM customer
       INNER JOIN `order`
          ON `order`.customer_id=customer.id) cust_ord
      ON vendor.city=cust_ord.city;

--------------------------------------------------
-- Cross join example
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
=============================================================================
-- 7. Groupping
SELECT vendor_id FROM `order`;
SELECT vendor_id FROM `order` GROUP BY vendor_id;
SELECT vendor_id, count(*) FROM `order` GROUP BY vendor_id;
SELECT vendor_id, count(*) FROM `order` GROUP BY vendor_id HAVING count(*) > 1;
SELECT vendor_id, order_date, MAX(summa) FROM `order` GROUP BY vendor_id, order_date;
SELECT vendor_id, order_date, MAX(summa) FROM `order` GROUP BY vendor_id, order_date HAVING MAX(summa)>100;

=========================================================================
-- Подзапросы для создания данных --------------------------------------
Определим группы по суммам продаж
SELECT 'Мало' name, 0 low_sum, 100 high_sum UNION
SELECT 'Средне' name, 100.01 low_sum, 500 high_sum UNION
SELECT 'Много' name, 500.01 low_sum, 100000 high_sum;

-- Найдем количество и сумму покупок по каждому покупателю
SELECT customer_id, count(*) num_orders, sum(summa) total
FROM `order`
GROUP BY customer_id;

-- Свяжем с таблицей customer для вывода фамилии покупателя
SELECT customer.name name, num_orders, total
FROM customer
   INNER JOIN 
        (SELECT customer_id, count(*) num_orders, sum(summa) total
        FROM `order`
        GROUP BY customer_id) customer_orders
      ON customer.id=customer_orders.customer_id;

-- Свяжем с группами по сумам продаж
SELECT customer.name name, num_orders, total, sum_groups.name
FROM customer
   INNER JOIN 
        (SELECT customer_id, count(*) num_orders, sum(summa) total
        FROM `order`
        GROUP BY customer_id) customer_orders
      ON customer.id=customer_orders.customer_id
   INNER JOIN
        (SELECT 'Мало' name, 0 low_sum, 100 high_sum
        UNION
        SELECT 'Средне' name, 100.01 low_sum, 500 high_sum
        UNION
        SELECT 'Много' name, 500.01 low_sum, 100000 high_sum) sum_groups
      ON customer_orders.total BETWEEN sum_groups.low_sum AND sum_groups.high_sum;
--------------------------------------------------------

-- Подзапрос внутри ORDER BY
SELECT c.name
FROM customer c
ORDER BY
(SELECT count(*) FROM `order` ord
    WHERE c.id=ord.customer_id) DESC;

-- Подзапрос в INSERT INTO
INSERT INTO `order` (summa, order_date, customer_id, vendor_id) VALUES (200.25, '2021-09-21', (SELECT id FROM customer WHERE name='Ли'), (SELECT id FROM vendor WHERE name='Петров'));



