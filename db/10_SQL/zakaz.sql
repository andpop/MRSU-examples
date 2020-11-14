-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Хост: 10.0.0.158:3308
-- Время создания: Апр 15 2020 г., 14:15
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
-- Структура таблицы `zakaz`
--

CREATE TABLE `zakaz` (
  `Zak_Nom` int(6) NOT NULL,
  `Zak_Summa` float NOT NULL,
  `Zak_Date` date NOT NULL,
  `Pok_Nom` int(6) NOT NULL,
  `Prod_Nom` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `zakaz`
--

INSERT INTO `zakaz` (`Zak_Nom`, `Zak_Summa`, `Zak_Date`, `Pok_Nom`, `Prod_Nom`) VALUES
(3001, 18.69, '2016-12-10', 2005, 1001),
(3002, 767.19, '2016-12-10', 2001, 1001),
(3003, 1900.1, '2016-12-10', 2002, 1003),
(3004, 123.45, '2016-12-15', 2003, 1002),
(3005, 100, '2016-12-16', 2004, 1002),
(3006, 95.13, '2016-12-15', 2001, 1001);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `zakaz`
--
ALTER TABLE `zakaz`
  ADD PRIMARY KEY (`Zak_Nom`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `zakaz`
--
ALTER TABLE `zakaz`
  MODIFY `Zak_Nom` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3007;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
