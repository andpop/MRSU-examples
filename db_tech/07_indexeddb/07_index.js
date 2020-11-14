let db;

let openRequest = indexedDB.open('test', 3);

openRequest.onerror = function () {
    console.log('open db request --- onerror');
    console.log('Ошибка при открытии БД. Код ошибки: ', event.target.errorCode);
    db = event.target.result;
};

openRequest.onsuccess = function (event) {
    console.log('open db --- onsuccess');
    db = event.target.result;

    let index = db.transaction('games').objectStore('games').index('name');

    index.get('Andrey').onsuccess = function (event) {
        const data = event.target.result;
        // console.log(data.result);
        console.log(data);
    }

    index.openCursor().onsuccess = function (event) {
        let cursor = event.target.result;
        if (cursor) {
            console.log('Name: ', cursor.key, ', Value: ', cursor.value);
            cursor.continue();
        }
    }
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

    let objectStore = event.currentTarget.transaction.objectStore('games');
    objectStore.createIndex('name', 'name', { unique: false });
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
