<?php

//Интерфейс стратегии сортировки массива
interface SortStrategy
{
    public function sort(array $dataset): array;
}

// Вариант стратегии
class BubbleSortStrategy implements SortStrategy
{
    public function sort(array $dataset): array
    {
        echo "Сортировка пузырьком\n";

        // Сортируем
        return $dataset;
    }
}

// Вариант стратегии
class QuickSortStrategy implements SortStrategy
{
    public function sort(array $dataset): array
    {
        echo "Быстрая сортировка\n";

        // Сортируем
        return $dataset;
    }
}

// Клиент, выбирающий вариант стратегии
class Sorter
{
    protected $sorter;

    public function __construct(SortStrategy $sorter)
    {
        $this->sorter = $sorter;
    }

    public function sort(array $dataset): array
    {
        return $this->sorter->sort($dataset);
    }
}



/////////////////////////////////////////////////////////////////////////////
// ===== Клиентский код ===================
/////////////////////////////////////////////////////////////////////////////

$dataset = [1, 5, 4, 3, 2, 8];

$sorter = new Sorter(new BubbleSortStrategy());
$sorter->sort($dataset); // Вывод : Сортировка пузырьком

$sorter = new Sorter(new QuickSortStrategy());
$sorter->sort($dataset); // Вывод : Быстрая сортировка
