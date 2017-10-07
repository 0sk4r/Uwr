function prime(num) {
    for (let i = 2; i < num; i++) {
        if (num % i === 0) return false
    }
    return true
}

var array = []

for (let i = 2; i < 100000; i++) {
    if (prime(i)) array.push(i);
}
console.log(array.length)