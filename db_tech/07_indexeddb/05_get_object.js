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
    
    objectStore = db.transaction('games').objectStore('games');

    objectStore.get(1).onsuccess = function (event) {
        console.log(event.target.result.name, event.target.result.result);
    }

    objectStore.getAll().onsuccess = function (event) {
        console.log(event.target.result);
    }
};

openRequest.onupgradeneeded = function () {
    console.log('open db --- onupgradeneeded');
};
