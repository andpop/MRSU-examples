<?php
// Обработка отправки формы
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Получаем данные из POST
    $name = $_POST['name'] ?? '';
    $email = $_POST['email'] ?? '';

    // Проверка заполнения полей
    if (empty($name) || empty($email)) {
        $error = 'Заполните все поля!';
    } else {
        // Экранирование вывода для безопасности
        $name = htmlspecialchars($name);
        $email = htmlspecialchars($email);
        
        // Вывод результата
        echo "<h2>Данные получены:</h2>";
        echo "Имя: $name<br>";
        echo "Email: $email";
        exit; // Прерываем выполнение после вывода результата
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Пример формы</title>
</head>
<body>
    <h1>Форма обратной связи</h1>
    
    <?php if (isset($error)): ?>
        <p style="color: red"><?= $error ?></p>
    <?php endif; ?>

    <form method="POST" action="">
        <label>
            Имя:<br>
            <input type="text" name="name" value="<?= htmlspecialchars($_POST['name'] ?? '') ?>">
        </label><br><br>
        
        <label>
            Email:<br>
            <input type="email" name="email" value="<?= htmlspecialchars($_POST['email'] ?? '') ?>">
        </label><br><br>
        
        <button type="submit">Отправить</button>
    </form>
</body>
</html>
