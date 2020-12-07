package pizzeria

import pizzeria.options._

case class Pizza(
                  pizzaType: PizzaType,
                  size: PizzaSize,
                  crust: CrustType,
                  extraMeat: Option[List[Meat]], //optional meat
                  extraTopping: Option[List[Topping]] //optional topping
                ) {
  val price: Double = {

    val basePrice: Double = pizzaType match {
      case Margarita => 5
      case Pepperoni => 6.5
      case Funghi => 7
    }

    val multiplier: Double = size match {
      case Small => 0.9
      case Regular => 1
      case Large => 1.5
    }

    val toppingCost: Double = extraTopping match {
      case Some(extras) => extras.map(_.price).sum
      case None => 0
    }

    (basePrice + meatCost + toppingCost) * multiplier

  }

  val meatCost: Double = extraMeat match {
    case Some(extras) => extras.map(_.price).sum
    case None => 0
  }

  override def toString(): String = {
    s"""Pizza ${pizzaType} in size ${size} on ${crust} crust with ${extraMeat.getOrElse("---")} meat
       |and ${extraTopping.getOrElse("---")} toppings""".stripMargin
  } //pretty print the pizza
}
