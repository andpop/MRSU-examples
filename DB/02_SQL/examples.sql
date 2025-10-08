-- 1. Create database 
CREATE DATABASE test_db CHARACTER SET = 'utf8';
USE test_db;

-- 2. Create tables
----- SQLite ---------------------
CREATE TABLE `vendors` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `percent` INTEGER NOT NULL CHECK (`percent`>0)
);

CREATE TABLE `customers` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `rating` INT(6) NOT NULL CHECK (`rating`>0),
  `vendor_id` INT(6) NULL
);

CREATE TABLE `orders` (
  `id` INTEGER PRIMARY KEY,
  `summa` NUMERIC NOT NULL,
  `order_date` DATE NOT NULL,
  `customer_id` INTEGER NOT NULL,
  `vendor_id` INTEGER NOT NULL
);


----- MySQL  ---------------------

CREATE TABLE `vendors` (
  `id` int(6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `percent` int(4) NOT NULL CHECK (`percent`>0)
) DEFAULT CHARSET=utf8;


CREATE TABLE `customers` (
  `id` int(6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `rating` int(3) NOT NULL CHECK (`rating`>0),
  `vendor_id` int(6) NULL
) DEFAULT CHARSCREATE TABLE `customers` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `rating` INTEGER NOT NULL CHECK (`rating`>0),
  `vendor_id` INTEGER NULL,
  FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) 
  ON DELETE SET NULL
);
SET=utf8;

CREATE TABLE `orders` (
  `id` int(6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `summa` float NOT NULL,
  `order_date` date NOT NULL,
  `customer_id` int(6) NOT NULL,
  `vendor_id` int(6) NOT NULL
) DEFAULT CHARSET=utf8;


-- 3. Insert rows
INSERT INTO `vendors` (`id`, `name`, `city`, `percent`) VALUES
(1001, 'Иванов', 'Саранск', 12),
(1002, 'Петров', 'Москва', 13),
(1003, 'Андреев', 'Кострома', 10),
(1004, 'Сидоров', 'Саранск', 10);

INSERT INTO `customers` (`id`, `name`, `city`, `rating`, `vendor_id`) VALUES
(2001, 'Потапов', 'Саранск', 100, 1001),
(2002, 'Гарин', 'Владимир', 200, 1003),
(2003, 'Ли', 'Москва', 200, 1002),
(2004, 'Глухов', 'Самара', 300, 1002),
(2005, 'Клюев', 'Саранск', 100, 1001);

INSERT INTO `orders` (`id`, `summa`, `order_date`, `customer_id`, `vendor_id`) VALUES
(3001, 18.69, '2016-12-10', 2005, 1001),
(3002, 767.19, '2016-12-10', 2001, 1001),
(3003, 1900.1, '2016-12-10', 2002, 1003),
(3004, 123.45, '2016-12-15', 2003, 1002),
(3005, 100, '2016-12-16', 2004, 1002),
(3006, 95.13, '2016-12-15', 2001, 1001);

-- 4. Relations and restrictions

----- SQLite  ---------------------
PRAGMA foreign_keys = ON;

DROP TABLE `orders`;
DROP TABLE `customers`;


CREATE TABLE `orders` (
  `id` INTEGER PRIMARY KEY,
  `summa` NUMERIC NOT NULL,
  `order_date` DATE NOT NULL,
  `customer_id` INTEGER NOT NULL,
  `vendor_id` INTEGER NOT NULL,
  FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE RESTRICT
);


CREATE TABLE `customers` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `rating` INTEGER NOT NULL CHECK (`rating`>0),
  `vendor_id` INTEGER NULL,
  FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) 
  ON DELETE SET NULL
);

CREATE TABLE `customers` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `rating` INTEGER NOT NULL CHECK (`rating`>0),
  `vendor_id` INTEGER NULL,
  FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) 
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE `customers` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `rating` INTEGER NOT NULL CHECK (`rating`>0),
  `vendor_id` INT(6) NULL,
  FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) 
  ON DELETE SET NULL
  ON UPDATE SET NULL
);

----- MySQL  ---------------------
ALTER TABLE `orders` ADD CONSTRAINT `order_vendors_fk` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE RESTRICT;
ALTER TABLE `customers` ADD CONSTRAINT `customers_vendors_fk` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE SET NULL;

SELECT 
  TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'example' AND
  REFERENCED_TABLE_NAME = 'vendors';



-- 5. Select from alone table
SELECT id, name, city FROM vendors;
SELECT * FROM vendors;

SELECT id, name, city FROM vendors WHERE city="Саранск";
SELECT * FROM customers WHERE rating>=200 AND city="Москва";
SELECT * FROM vendors WHERE city IN ("Москва", "Саранск");

SELECT * FROM customers WHERE name LIKE "По%";
SELECT * FROM customers WHERE name RLIKE "ов$"; // MySQL
SELECT * FROM customers WHERE LEFT(name, 2) = "Ив";  // MySQL
SELECT * FROM customers WHERE substr(name, 1, 2) = "Ив";  // SQLite

SELECT CONCAT(LEFT(name,2),".-", city) AS "Фамилия-Город" FROM vendors; // MySQL
SELECT substr(name,1,2) || ".-" || city AS "Фамилия-Город" FROM vendors; // SQLite

SELECT * FROM vendors ORDER BY name;

-- 6. Aggregation
SELECT SUM(summa) FROM `orders`;
SELECT COUNT(*) FROM customers;

-- 7. Groupping
SELECT vendor_id, MAX(summa) FROM `orders` GROUP BY vendor_id;
SELECT vendor_id, order_date, MAX(summa) FROM `orders` GROUP BY vendor_id, order_date;
SELECT vendor_id, order_date, MAX(summa) FROM `orders` GROUP BY vendor_id, order_date HAVING MAX(summa)>100;

-- 8. Inner join
SELECT customers.name, vendors.name, vendors.city FROM vendors, customers WHERE vendors.city=customers.city;
SELECT customers.name, vendors.name, vendors.city FROM vendors INNER JOIN customers ON vendors.city=customers.city;

--9. Self-join
SELECT a.name AS customers1, b.name AS customers2, a.rating FROM customers a, customers b WHERE a.rating=b.rating;

-- 10. Outer join
SELECT vendors.name, customers.name FROM vendors LEFT OUTER JOIN customers ON vendors.id = customers.vendor_id;
SELECT vendors.name, customers.name FROM customers RIGHT OUTER JOIN vendors ON vendors.id = customers.vendor_id;

-- 11. Nested queries
SELECT * FROM `orders` WHERE vendor_id = (SELECT id FROM vendors WHERE name="Иванов");
SELECT * FROM `orders` WHERE vendor_id IN (SELECT id FROM vendors WHERE name="Иванов");

SELECT rating, COUNT(DISTINCT id) FROM customers GROUP BY rating HAVING rating > (SELECT AVG(rating) FROM customers WHERE city="Саранск");

-- 12. Related queries
SELECT * FROM customers a WHERE "2016-12-10" IN (SELECT order_date FROM `orders` b WHERE a.id = b.customer_id);
SELECT id, name FROM vendors main WHERE 1 < (SELECT COUNT(*) FROM customers WHERE vendor_id=main.id);
SELECT * FROM `orders` a WHERE summa > (SELECT AVG(summa) FROM `orders` b WHERE a.customer_id = b.customer_id);

-- 13. exists, any, all
SELECT DISTINCT vendor_id FROM customers a WHERE EXISTS (SELECT * FROM customers b WHERE b.vendor_id = a.vendor_id AND b.id <> a.id);
SELECT * FROM `orders` WHERE summa > ALL (SELECT summa FROM `orders` WHERE order_date="2016-12-10");
SELECT * FROM `orders` WHERE summa > ANY (SELECT summa FROM `orders` WHERE order_date="2016-12-10");

-- 13. CASE
SELECT id, name AS 'Фамилия', CASE city WHEN 'Саранск' THEN 'Да' ELSE 'Нет' END 'Земляк' FROM customers;
SELECT id, name AS 'Фамилия', CASE WHEN rating >= 300 THEN 'Молодец' WHEN rating >=200 THEN 'Неплохо' ELSE 'Старайся больше' END 'Оценка по рейтингу' FROM customers;

-- 14. Window functions
SELECT *, ROW_NUMBER() OVER () AS number FROM customers;
SELECT *, ROW_NUMBER() OVER (ORDER BY rating DESC) AS rating_place FROM customers ORDER BY name;
SELECT *, RANK() OVER (ORDER BY rating DESC) AS rank FROM customers ORDER BY name;
SELECT name, city, rating, AVG(rating) OVER () AS average_rating FROM customers;
SELECT name, city, rating, rating-AVG(rating) OVER () AS delta_rating FROM customers;

SELECT *, MAX(rating) FROM customers;
SELECT *, MAX(rating) OVER () FROM customers;

SELECT *, COUNT(*) OVER (PARTITION BY city) AS customerss_in_city FROM customers;

-- 15. Union
SELECT name, city, 'Продавец' AS 'Роль' FROM vendors
UNION
SELECT name, city, 'Покупатель' FROM customers
ORDER BY city, name;

-- 16. Views

CREATE VIEW orders_with_names
AS SELECT `orders`.order_date, customers.name AS customers_name, vendors.name AS vendors_name, `orders`.summa
FROM `orders`, customers, vendors
WHERE `orders`.customer_id = customers.id AND `orders`.vendor_id = vendors.id;

SELECT * FROM orders_with_names;


-- 17. Common Table Exprssions

WITH
  orders_with_names AS (SELECT `orders`.order_date, customers.name AS customers_name, vendors.name AS vendors_name, `orders`.summa
  FROM `orders`, customers, vendors
  WHERE `orders`.customer_id = customers.id AND `orders`.vendor_id = vendors.id)
SELECT * FROM orders_with_names ORDER BY summa;


-- 18. Stored procedures, functions and triggers

DELIMITER //
CREATE PROCEDURE ChangeName()
BEGIN
    SELECT * FROM customers;
    UPDATE customers SET name = "Шаров" WHERE id = 2001;
    SELECT * FROM customers;
END; //
DELIMITER ;

CALL ChangeName();
--------------------------------------
DELIMITER //
CREATE PROCEDURE ChangeNameWithParameter(value varchar(30))
BEGIN
    SELECT * FROM customers;
    UPDATE customers SET name = value WHERE id = 2001;
    SELECT * FROM customers;
END; //
DELIMITER ;

CALL ChangeNameWithParameter("Бульба");

-----------  Functions  --------------------------------------
SET GLOBAL log_bin_trust_function_creators = 1;

# Add the following to the mysql.ini configuration file:
# log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION Hello(name char(20)) RETURNS char(50)
  BEGIN
    RETURN CONCAT('Привет, ', name, '!');
  END //
DELIMITER ';'

SELECT Hello('Андрей');
-----------------------------------------

DELIMITER //
CREATE FUNCTION GetvendorsForcustomers(customers_name varchar(30)) RETURNS varchar(30)
BEGIN
  DECLARE vendors_name varchar(30);
  SELECT name INTO vendors_name FROM vendors WHERE id IN (SELECT vendor_id FROM customers WHERE name = customers_name ) LIMIT 1;
  RETURN vendors_name;
END //
DELIMITER ';'

SELECT GetvendorsForcustomers('Ли');

-----------  Cursors  -------------------------------------

CREATE TABLE c1(i INT);

CREATE TABLE c2(i INT);

CREATE TABLE c3(i INT);

DELIMITER //

CREATE PROCEDURE p1()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE x, y INT;
  DECLARE cur1 CURSOR FOR SELECT i FROM c1;
  DECLARE cur2 CURSOR FOR SELECT i FROM c2;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;
  OPEN cur2;

  read_loop: LOOP
    FETCH cur1 INTO x;
    FETCH cur2 INTO y;
    IF done THEN
      LEAVE read_loop;
    END IF;
    IF x < y THEN
      INSERT INTO c3 VALUES (x);
    ELSE
      INSERT INTO c3 VALUES (y);
    END IF;
  END LOOP;

  CLOSE cur1;
  CLOSE cur2;
END; //

DELIMITER ';'

INSERT INTO c1 VALUES(5),(50),(500);

INSERT INTO c2 VALUES(10),(20),(30);

CALL p1;

SELECT * FROM c3;

----------  Triggers -------------------------------------------

SET @total = 0;

DELIMITER //
CREATE TRIGGER order_after_insert AFTER INSERT ON `orders`
FOR EACH ROW
BEGIN
  SET @total = @total + NEW.summa;
END //

DELIMITER ';'


SELECT @total;
INSERT INTO `orders` (`summa`, `order_date`, `customer_id`, `vendor_id`) VALUES (130.45, '2020-05-10', 2005, 1001);
SELECT @total;
