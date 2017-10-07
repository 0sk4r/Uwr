function fib1(num) {
    if (num == 0) return 0
    else if (num == 1) return 1
    else return fib1(num - 1) + fib1(num - 2)
}

function fib2(num) {
    let a = 0,
        b = 1;
    for (let i = 0; i < num; i++) {
        [a, b] = [b, a + b];
    }
    return a
}

console.log("Fibonaci recursive: ")

for(let i = 10; i <=40; i +=10){
    let start = new Date();
    fib1(i);
    let end = new Date();
    let diff = end.getTime() - start.getTime();
    console.log("recursive: %d ms",diff);
}

console.log("Fibonaci itterative: ")

for(let i = 10; i <=40; i +=10){
    let start = new Date();
    fib2(i);
    let end = new Date();
    let diff = end.getTime() - start.getTime();
    console.log("recursive: %d ms",diff);
}