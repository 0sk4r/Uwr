var Foo = (function () {

  var Qux = function() {console.log("qux")}; //prywatne



  var Bar = function () {
    console.log("Wywołanie z Bar: ");
    Qux()
  };

  return Bar;
})();

var foo = new Foo();

foo.Bar;

console.log("wywolannie z zewnatrz:");
foo.Qux;
