// Запуск сервера и оболочки
sudo systemctl start mongod
mongod

// Начало
help
show dbs

use univer
db.getCollectionNames()

// Вставка документов с автоматической генерацией _id
db.vendor.insert({name: 'Потапкин', city: 'Саранск', percent: '14'})
db.vendor.insert({name: 'Петров', city: 'Москва', percent: '15'})
db.vendor.insert({name: 'Андреев', city: 'Кострома', percent: '12'})
db.vendor.insert({name: 'Сидоров', city: 'Саранск', percent: '12'})
db.vendor.insert({name: 'Козлов', city: 'Саранск', percent: '26'})

db.vendor.find().pretty()

db.vendor.drop()
db.vendor.insert({_id: 1, name: 'Потапкин', city: 'Саранск', percent: '14'})
db.vendor.insert({_id: 2, name: 'Петров', city: 'Москва', percent: '15'})
db.vendor.insert({_id: 3, name: 'Андреев', city: 'Кострома', percent: '12'})
db.vendor.insert({_id: 4, name: 'Сидоров', city: 'Саранск', percent: '12'})
db.vendor.insert({_id: 5, name: 'Козлов', city: 'Саранск', percent: '26'})


db.customer.insertMany([
    {_id: 1, name: 'Боков', city: 'Саранск', rating: '100'},
    {_id: 2, name: 'Гарин', city: 'Владимир', rating: '200'},
    {_id: 3, name: 'Ли', city: 'Москва', rating: '300'},
    {_id: 4, name: 'Глухов', city: 'Самара', rating: '100'},
    {_id: 5, name: 'Клюев', city: 'Саранск', rating: '100'}
]) 

// Селекторы запросов (условия)
db.vendor.find({city: 'Саранск'})
// Перечисление селекторов = логическое И, для операций сравнения специальные объекты
db.vendor.find({city: 'Саранск', percent: {$gt: '14'}})
- $eq (равно)
- $gt (больше чем)
- $lt (меньше чем)
- $gte (больше или равно)
- $lte (меньше или равно)

// Проекция
db.vendor.find({city: 'Саранск'}, {name: 1, city: 1})

// Подсчет возвращаемы документов
db.vendor.find({city: 'Саранск', percent: {$gt: '14'}}).count()

// Сортировка (1 -- по возрастанию, -1 -- по убыванию)
db.customer.find().sort({name: 1})

// Изменения в документах
db.customer.update({name: 'Боков'}, {$set: {rating: 150}})

// Удаление документов
db.customer.remove({name: 'Гарин'}) 
db.customer.remove({name: 'Гарин'}, true)  // удаление одной записи по селектору
db.customer.remove({name: 'Гарин'}, false)  // удаление всех записей по селектору
db.customer.remove({})  // удаление всех записей


// Связанные объекты в массивах
db.customer.updateOne({name: 'Боков'}, {
    $set: {orders: [
        {
            date: '2020-05-18',
            summa: 123.45
        },
        {
            date: '2020-05-19',
            summa: 300
        }
    ]}
})


db.customer.updateOne({name: 'Боков'}, {
    $push: {
        orders: {date: '2020-05-21',summa: 600}
    }
})

// Нормализованные данные
db.customer.updateOne({name: 'Боков'}, {
    $set: {vendor_id: 2}
})

// Добавление данных из связанной коллекции
db.customer.aggregate([
    {
        $lookup: {
            from: 'vendor',
            localField: 'vendor_id',
            foreignField: '_id',
            as: 'vendor_info'
        }
    }
])