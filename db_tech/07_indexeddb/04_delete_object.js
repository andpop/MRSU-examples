let db;

let openRequest = indexedDB.open('test', 2);

openRequest.onerror = function () {
    console.log('open db request --- onerror');
    console.log('Ошибка при открытии БД. Код ошибки: ', event.target.errorCode);
    db = event.target.result;
};

openRequest.onsuccess = function (event) {
    console.log('open db --- onsuccess');
    db = event.target.result;

    delName(db);
};

openRequest.onupgradeneeded = function (event) {
    console.log('open db --- onupgradeneeded');

    db = event.target.result;
    
    if (!db.objectStoreNames.contains('games')) {
        db.createObjectStore('games', {keyPath: 'id', autoIncrement: true});
    };
    if (!db.objectStoreNames.contains('names')) {
        db.createObjectStore('names', {autoIncrement: true});
    };
};

// ----------------------------------------------------------
function delName(db) {
    let request = db
        .transaction('names', 'readwrite')
        .objectStore('names')
        .delete(2);


    request.onsuccess = function () {
        console.log('Имя удалено из БД');

    };

    request.onerror = function (event) {
        console.log('Ошибка при удалении объекта из БД', event.target.error);
    };
};
