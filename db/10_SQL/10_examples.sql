-- 1. Create database 
CREATE DATABASE test_db CHARACTER SET = 'utf8';
USE test_db;

-- 2. Create tables
CREATE TABLE `vendor` (
  `id` int(6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `percent` int(4) NOT NULL CHECK (`percent`>0)
) DEFAULT CHARSET=utf8;


CREATE TABLE `customer` (
  `id` int(6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `rating` int(3) NOT NULL CHECK (`rating`>0),
  `vendor_id` int(6) NULL
) DEFAULT CHARSET=utf8;

CREATE TABLE `order` (
  `id` int(6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `summa` float NOT NULL,
  `order_date` date NOT NULL,
  `customer_id` int(6) NOT NULL,
  `vendor_id` int(6) NOT NULL
) DEFAULT CHARSET=utf8;


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

-- 4. Relations and restrictions

ALTER TABLE `order` ADD CONSTRAINT `order_vendor_fk` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE RESTRICT;
ALTER TABLE `customer` ADD CONSTRAINT `customer_vendor_fk` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE SET NULL;

SELECT 
  TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'example' AND
  REFERENCED_TABLE_NAME = 'vendor';



-- 5. Select from alone table
SELECT id, name, city FROM vendor;
SELECT * FROM vendor;

SELECT id, name, city FROM vendor WHERE city="Саранск";
SELECT * FROM customer WHERE rating>=200 AND city="Москва";
SELECT * FROM vendor WHERE city IN ("Москва", "Саранск");

SELECT * FROM customer WHERE name LIKE "Ив%";
SELECT * FROM customer WHERE name RLIKE "ов$";
SELECT * FROM customer WHERE LEFT(name, 2) = "Ив";

SELECT CONCAT(LEFT(name,2),".-", city) AS "Фамилия-Город" FROM vendor;
SELECT * FROM vendor ORDER BY name;

-- 6. Aggregation
SELECT SUM(summa) FROM `order`;
SELECT COUNT(*) FROM customer;

-- 7. Groupping
SELECT vendor_id, MAX(summa) FROM `order` GROUP BY vendor_id;
SELECT vendor_id, order_date, MAX(summa) FROM `order` GROUP BY vendor_id, order_date;
SELECT vendor_id, order_date, MAX(summa) FROM `order` GROUP BY vendor_id, order_date​ HAVING MAX(summa)>100;

-- 8. Inner join
SELECT customer.name, vendor.name, vendor.city FROM vendor, customer WHERE vendor.city=customer.city;
SELECT customer.name, vendor.name, vendor.city ​FROM vendor INNER JOIN customer ON vendor.city=customer.city;

--9. Self-join
SELECT a.name AS Customer1, b.name AS Customer2, a.rating FROM customer a, customer b WHERE a.rating=b.rating;

-- 10. Outer join
SELECT vendor.name, customer.Pok_Name FROM vendor LEFT OUTER JOIN customer ON vendor.id = customer.id;
SELECT vendor.name, customer.name FROM customerRIGHT OUTER JOIN vendor ON vendor.id = customer.id;

-- 11. Nested queries
SELECT * FROM `order` WHERE id = (SELECT id FROM vendor WHERE name="Иванов");
SELECT * FROM `order` WHERE id IN (SELECT id FROM vendor WHERE name="Иванов");

SELECT rating, COUNT(DISTINCT id) FROM customer GROUP BY rating HAVING rating > (SELECT AVG(rating) FROM customer WHERE city="Саранск");

-- 12. Related queries
SELECT * FROM customer a WHERE “2016-12-10” IN (SELECT order_date FROM `order` b WHERE a.id = b.id);
SELECT id, name FROM vendor main WHERE 1 < (SELECT COUNT(*) FROM customer WHERE vendor_id=main.id);
SELECT * FROM `order` a WHERE summa > (SELECT AVG(summa) FROM `order` b WHERE a.customer_id = b.customer_id);

-- 13. exists, any, all
SELECT DISTINCT vendor_id FROM customer a WHERE EXISTS (SELECT * FROM customer b WHERE b.vendor_id = a.vendor_id AND b.id <> a.id);
SELECT * FROM `order` WHERE summa > ALL (SELECT summa FROM `order` WHERE order_date=“2016-12-10”);
SELECT * FROM `order` WHERE summa > ANY (SELECT summa FROM `order` WHERE order_date=“2016-12-10”);

-- 14. Window functions
SELECT *, ROW_NUMBER() OVER () AS number FROM customer;
SELECT *, ROW_NUMBER() OVER (ORDER BY rating DESC) AS rating_place FROM customer ORDER BY name;
SELECT *, RANK() OVER (ORDER BY rating DESC) AS rank FROM customer ORDER BY name;
SELECT name, city, rating, AVG(rating) OVER () AS average_rating FROM customer;
SELECT name, city, rating, rating-AVG(rating) OVER () AS delta_rating FROM customer;

SELECT *, MAX(rating) FROM customer;
SELECT *, MAX(rating) OVER () FROM customer;

SELECT *, COUNT(*) OVER (PARTITION BY city) AS customers_in_city FROM customer;

-- 15. Views

CREATE VIEW orders_with_names
AS SELECT `order`.order_date, customer.name AS customer_name, vendor.name AS vendor_name, `order`.summa
FROM `order`, customer, vendor
WHERE `order`.customer_id = customer.id AND `order`.vendor_id = vendor.id;

SELECT * FROM orders_with_names;

-- 15. Stored procedures, functions and triggers

DELIMITER //
CREATE PROCEDURE ChangeName()
BEGIN
    SELECT * FROM customer;
    UPDATE customer SET name = "Шаров" WHERE id = 2001;
    SELECT * FROM customer;
END; //
DELIMITER ;

CALL ChangeName();
--------------------------------------
​
DELIMITER //
CREATE PROCEDURE ChangeNameWithParameter(value varchar(30))
BEGIN
    SELECT * FROM customer;
    UPDATE customer SET name = value WHERE id = 2001;
    SELECT * FROM customer;
END; //
DELIMITER ;

CALL ChangeNameWithParameter("Бульба");

-----------  Functions  --------------------------------------
​
SET GLOBAL log_bin_trust_function_creators = 1;

# Add the following to the mysql.ini configuration file:
# log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION Hello(name char(20)) RETURNS char(50)
  BEGIN
    RETURN CONCAT('Привет, ', name, '!');
  END //
​DELIMITER ';'

SELECT Hello('Андрей');
-----------------------------------------

DELIMITER //
CREATE FUNCTION GetVendorForCustomer(customer_name varchar(30)) RETURNS varchar(30)
BEGIN
  DECLARE vendor_name varchar(30);
  SELECT name INTO vendor_name FROM vendor WHERE id IN (SELECT vendor_id FROM customer WHERE name = customer_name ) LIMIT 1;
  RETURN vendor_name;
END //
DELIMITER ';'

SELECT GetVendorForCustomer('Ли');

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
CREATE TRIGGER order_after_insert AFTER INSERT ON `order`
FOR EACH ROW
BEGIN
  SET @total = @total + NEW.summa;
END //

DELIMITER ';'


SELECT @total;
INSERT INTO `order` (`summa`, `order_date`, `customer_id`, `vendor_id`) VALUES (130.45, '2020-05-10', 2005, 1001);
SELECT @total;