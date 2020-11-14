let db;

let openRequest = indexedDB.open('test', 1);

// console.dir(openRequest);

openRequest.onerror = function () {
    console.log('open db request --- onerror');
    console.log('Ошибка при открытии БД. Код ошибки: ', event.target.errorCode);
    db = event.target.result;
};

openRequest.onsuccess = function () {
    console.log('open db request --- onsuccess');
    db = event.target.result;
};

openRequest.onupgradeneeded = function () {
    console.log('open db request --- onupgradeneeded');
    db = openRequest.result;
    
    if (!db.objectStoreNames.contains('games')) {
        db.createObjectStore('games', {keyPath: 'id', autoIncrement: true});
    };
};
