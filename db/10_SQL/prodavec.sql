-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Хост: 10.0.0.158:3308
-- Время создания: Апр 15 2020 г., 14:14
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
-- Структура таблицы `prodavec`
--

CREATE TABLE `prodavec` (
  `Prod_Nom` int(6) NOT NULL,
  `Prod_Name` varchar(30) NOT NULL,
  `City` varchar(30) NOT NULL,
  `Procent` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prodavec`
--

INSERT INTO `prodavec` (`Prod_Nom`, `Prod_Name`, `City`, `Procent`) VALUES
(1001, 'Иванов', 'Саранск', 12),
(1002, 'Петров', 'Москва', 13),
(1003, 'Андреев', 'Кострома', 10),
(1004, 'Сидоров', 'Саранск', 10);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `prodavec`
--
ALTER TABLE `prodavec`
  ADD PRIMARY KEY (`Prod_Nom`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `prodavec`
--
ALTER TABLE `prodavec`
  MODIFY `Prod_Nom` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1005;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
