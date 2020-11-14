-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Хост: 10.0.0.158:3308
-- Время создания: Апр 15 2020 г., 14:13
-- Версия сервера: 5.5.62-38.14-log
-- Версия PHP: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `andpop_mybase`
--

-- --------------------------------------------------------

--
-- Структура таблицы `pokupatel`
--

CREATE TABLE `pokupatel` (
  `Pok_Nom` int(6) NOT NULL,
  `Pok_Name` varchar(30) NOT NULL,
  `City` varchar(30) NOT NULL,
  `Rating` int(3) NOT NULL,
  `Prod_Nom` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pokupatel`
--

INSERT INTO `pokupatel` (`Pok_Nom`, `Pok_Name`, `City`, `Rating`, `Prod_Nom`) VALUES
(2001, 'Потапов', 'Саранск', 100, 1001),
(2002, 'Гарин', 'Владимир', 200, 1003),
(2003, 'Ли', 'Москва', 200, 1002),
(2004, 'Глухов', 'Самара', 300, 1002),
(2005, 'Клюев', 'Саранск', 100, 1001);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `pokupatel`
--
ALTER TABLE `pokupatel`
  ADD PRIMARY KEY (`Pok_Nom`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `pokupatel`
--
ALTER TABLE `pokupatel`
  MODIFY `Pok_Nom` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2006;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
