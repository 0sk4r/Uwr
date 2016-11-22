function Vehicle(position, fuel, tank){
  this.currentPosition = position;
  this.fuelConsumption = fuel;
  this.tankStatus = tank;
  this.move = function(x,y){
    this.tankStatus = this.tankStatus - this.fuelConsumption*(x*x+y*y);
    this.currentPosition[0]+=x;
    this.currentPosition[1]+=y;
  };
  
  this.loadFuel = function(x){
    this.tankStatus +=x;
  };
}
Vehicle.prototype = {
  get position(){
    return this.currentPosition;
  },
  get fuel(){
    return this.tankStatus;
  }}
  
function Car(position, fuel, tank)
{
  Vehicle.call(this,position,fuel,tank);
}

Car.prototype = Object.create(Vehicle.prototype);

function Truck(position,fuel, tank){
  Vehicle.call(this,position,fuel,tank);
}

Truck.prototype = Object.create(Vehicle.prototype);

var auto = new Car([0,0],2,30);
var ciezarowka = new Truck([0,0],5,100);

auto.move(2,3);
console.log(auto.position);
console.log(auto.fuel);
auto.loadFuel(30);
console.log(auto.fuel);

ciezarowka.move(2,3);
console.log(ciezarowka.position);
console.log(ciezarowka.fuel);
ciezarowka.loadFuel(30);
console.log(ciezarowka.fuel);

