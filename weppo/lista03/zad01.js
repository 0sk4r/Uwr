var obj = {
    a: 1,
    get get_a() { return `wartosc a: ${this.a}`;},
    set set_a(x) {this.a = x;}

};

console.log(obj.a);
console.log(obj.get_a);
obj.set_a = 5
console.log(obj.get_a);

obj.b = 4;
console.log(obj.b);
obj.new_function = function () {
    console.log("nowa funkcja");
}
obj.new_function();
Object.defineProperty(obj,'get_b', { get: function() {return `wartosc a: ${this.a}`;}});
Object.defineProperty(obj,'set_b', { set: function(x) { this.a = x;}});

console.log(obj.get_b);
obj.set_b = 10;
console.log(obj.get_b);