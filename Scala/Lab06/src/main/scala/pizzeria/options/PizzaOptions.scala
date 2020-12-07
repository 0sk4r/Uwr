package pizzeria.options

abstract class PizzaType(val price: Double)

case object Margarita extends PizzaType(5)

case object Pepperoni extends PizzaType(6.5)

case object Funghi extends PizzaType(7)

abstract class PizzaSize

case object Small extends PizzaSize

case object Regular extends PizzaSize

case object Large extends PizzaSize

abstract class CrustType

case object Thin extends CrustType

case object Thick extends CrustType

abstract class Topping(val price: Double)

case object Ketchup extends Topping(0.5)

case object Garlic extends Topping(0.5)

abstract class Meat(val price: Double)

case object Salami extends Meat(1)

abstract class Drink(val price: Double)

case object Lemonade extends Drink(2)

abstract class Discount

case object Student extends Discount

case object Senior extends Discount
