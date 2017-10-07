function foo(num) {
    let sum = 0
    let temp = num
    while (num > 0) {
        let digit = num % 10;
        sum += digit
        if (temp % digit !== 0) return false
        num = Math.floor(num / 10);
    }
    if (temp % sum === 0) return true
    else return false
}

var array = []

for (var i = 1; i <= 30; i++) {
    if (foo(i)) {
        array.push(i);
    }
}

console.log(array);

foo(10);