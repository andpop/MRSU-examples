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

    getAllGames(db);
};

openRequest.onupgradeneeded = function (event) {
    console.log('open db --- onupgradeneeded');
};

function getAllGames() {
    let objectStore = db.transaction('games').objectStore('games');

    objectStore.openCursor().onsuccess = function (event) {
        let cursor = event.target.result;
        if (cursor) {
            console.log('Game ', cursor.key, ': ', cursor.value.name, cursor.value.result);
            cursor.continue();
        } else {
            console.log('No more records');
        }
    }
}