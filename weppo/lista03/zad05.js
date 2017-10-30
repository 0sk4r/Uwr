function sumList(x){
    var args = [].slice.call(arguments);
    return args.reduce((a, b) => a + b, 0);
}

console.log(sumList());
console.log(sumList(1));
console.log(sumList(1,2,3));
console.log(sumList(1,2,3,4,5,6));