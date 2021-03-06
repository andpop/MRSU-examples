## Создание объектов
Объект можно создать тремя способами:
1. Объектный литерал
2. `Object.create()`
3. Оператор new
Примеры, значение this в них

### Объектные литералы и деструктуризация по объекту


## Что такое this?
* this вне функции указывает на глобальный объект. Примеры в браузере и в Node.js

* this внутри функции - это контекст, в котором вызвана эта функция, т.е. объект, с которым эта функция связана. 
Определяется местом вызова функции, а не местом, в котором она объявлена.

## Правила для this в случае обычных функций

=============================================================================================
В JavaScript вызываемая функция будет иметь *собственный контекст* лишь в трёх случаях (в порядке приоритета):

1. Функция вызывается с помощью ключевого слова new.
В этом случе this связано с создаваемым новым объектом.

2. Для вызова функции используется метод bind, call или apply.
f.call(a)  // внутри f this = a
В этом случае this связано с указанным в этом методе объектом.

3. Функция вызывается в виде метода объекта, то есть через точку или квадратные скобки:
    например, a.f() или a['f']()  // внутри f this = a
В этом случае this связано с этим объектом-владельцем

=============================================================================================

В остальных случаях контекст сбрасывается на контекст по умолчанию:
* глобальный объект, если скрипт запущен в нестрогом режиме,
* undefined, если скрипт запущен в строгом режиме ('use strict').

## Примеры потери контекста


## this и стрелочные функции
Стрелочные функции всегда принимают связывание this от внешней области видимости (функциональной или глобальной).
То есть от области, где они были объявлены, а не откуда были вызваны!

## Правило для безопасного использования this
Динамическая установка this, подчиняющаяся запутанному набору правил, – источник всяческих проблем. Чтобы избежать неприятностей, не используйте this внутри функций, определенных с помощью ключевого слова function.
Безопасно использовать this в методах и конструкторах, а также в стрелочных функциях, определенных внутри методов и конструкторов.
