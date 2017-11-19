var Person = (function () {

  var name = "Adam"; //prywatne



  var PersonIn = function () {
    this.getName = function () {
      return name;
    };

    this.setName = function (x) {
      name = x;
    };
  };

  return PersonIn;
})();

var person = new Person();

person.name = "Krzysztof";

console.log(person.getName());

person.setName("Karol");

console.log(person.getName());