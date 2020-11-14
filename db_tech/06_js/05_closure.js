function makeCounter() {
    let count = 0;
  
    return function() {
      return count++; // есть доступ к внешней переменной "count"
    };
  }
  
  let counter = makeCounter();
  
  console.log( counter() ); // 0
  console.log( counter() ); // 1
  console.log( counter() ); // 2
  
//   let counter1 = makeCounter();
//   let counter2 = makeCounter();
  
//   console.log( counter1() ); // 0
//   console.log( counter1() ); // 1
  
//   console.log( counter2() ); // 0 
  