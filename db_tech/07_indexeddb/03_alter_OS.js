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

    addGame(); 
    addGame(); 
    addName(db);
    addName(db);
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
function addGame() {
    let transaction = db.transaction('games', 'readwrite');
    let games = transaction.objectStore('games');

    let game = {
        name: 'Andrey',
        result: 'loose'
    };

    let request = games.add(game);

    request.onsuccess = function () {
        console.log('Партия записана в БД');
    };

    request.onerror = function (event) {
        console.log('Ошибка при записи в БД', event.target.error);
    };
};

function addName(db) {
    let transaction = db.transaction('names', 'readwrite');
    let names = transaction.objectStore('names');

    let name = {
        name: 'Andrey',
        lastname: 'Popov'
    };

    let request = names.add(name);

    request.onsuccess = function () {
        console.log('Имя записано в БД');
    };

    request.onerror = function (event) {
        console.log('Ошибка при записи в БД', event.target.error);
    };
};
