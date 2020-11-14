console.log('Hello from 01.js');

let openRequest = indexedDB.open('test', 1);

openRequest.onsuccess = function () {
    console.log('open db onsuccess');
    let db = openRequest.result;
};

openRequest.onupgradeneeded = function () {
    console.log('open db onupgradeneeded');
    let db = openRequest.result;
    if (!db.objectStoreNames.contains('plays')) {
        db.createObjectStore('plays', {keyPath: 'id'});
    };
};
