var obj = {
    _a: 1,
    get a() { return `wartosc a: ${this._a}`;},
    set a(x) {this._a = x;}

};

console.log(obj._a);
console.log(obj.a);
obj.a = 5
console.log(obj.a);

obj.new_function = function () {
    console.log("nowa funkcja");
}
obj.new_function();

Object.defineProperty(obj,'value', { get: function() {return `wartosc c: ${this.c}`;},
                                    set: function(x) { this.c = x;}});


console.log(obj.value);
obj.value = 10;
console.log(obj.value);