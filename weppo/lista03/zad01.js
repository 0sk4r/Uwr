var obj = {
    a: 1,
    get get_a() { return `wartosc a: ${this.a}`;},
    set set_a(x) {this.a = x;}

};

var o = {
    a: 7,
    get b() { return this.a + 1; },
    set c(x) { this.a = x / 2; }
  };

console.log(obj.a);
console.log(obj.get_a);
obj.set_a = 5
console.log(obj.get_a);kjllkdas
