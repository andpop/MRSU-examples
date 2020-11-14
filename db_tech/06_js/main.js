import {sum} from './module1.js';
import {el} from './module2.js';

console.log(sum(2, 3));

el.addEventListener('click', function(event) {
    console.log('Click2!');
    event.target.style.color = "red";
});