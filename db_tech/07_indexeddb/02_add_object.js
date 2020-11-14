let db;

let openRequest = indexedDB.open('test', 1);

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
};

openRequest.onupgradeneeded = function (event) {
    console.log('open db --- onupgradeneeded');
    db = event.target.result;
    if (!db.objectStoreNames.contains('games')) {
        db.createObjectStore('games', {keyPath: 'id', autoIncrement: true});
    };
};

// ---------------------------------------------------
function addGame() {
    let transaction = db.transaction('games', 'readwrite');
    let games = transaction.objectStore('games');

    let game = {
        name: 'Sergey',
        result: 'win'
    };

    let request = games.add(game);
    console.dir(request);

    request.onsuccess = function () {
        console.log('Партия записана в БД');
    };

    request.onerror = function (event) {
        console.log('Ошибка при записи в БД', event.target.error);
    };
};
