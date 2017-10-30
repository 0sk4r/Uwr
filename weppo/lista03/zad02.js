var fibonacci = (function() {
    var cache = {};
  
    function f(n) {
      var value;
  
      if (n in cache) {
        value = cache[n];
      } else {
        if (n === 0 || n === 1)
          value = n;
        else
          value = f(n - 1) + f(n - 2);
  
        cache[n] = value;
      }
  
      return value;
    }
  
    return f;
  })();



function fib1(num) {
  if (num == 0) return 0
  else if (num == 1) return 1
  else return fib1(num - 1) + fib1(num - 2)
}

for(let i = 10; i <=40; i +=10){
  console.time("recursive");
  fib1(i);
  console.timeEnd("recursive");
}

console.log("Fibonaci itterative: ")

for(let i = 10; i <=40; i +=10){
  console.time("iterative");
  fibonacci(i);
  console.timeEnd("iterative");
}