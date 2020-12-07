package pizzeria.orders

import pizzeria.Pizza
import pizzeria.options._

class Order(
             name: String,
             address: String,
             phone: String,
             pizzas: Option[List[Pizza]],
             drinks: Option[List[Drink]],
             discount: Option[Discount] = None,
             specialInfo: Option[String] = None
           ) {

  val price: Double = {
    val studentDiscountMultiplier: Double = 0.95
    val seniorDiscountMultiplier: Double = 0.93

    val pizzaPriceWithoutDiscount: Double = pizzasPrice.getOrElse(0)
    val drinksPriceWithoutDiscount: Double = drinksPrice.getOrElse(0)
    discount match {
      case Some(value) => value match {
        case Student => studentDiscountMultiplier * pizzaPriceWithoutDiscount + drinksPriceWithoutDiscount
        case Senior => seniorDiscountMultiplier * (pizzaPriceWithoutDiscount + drinksPriceWithoutDiscount)
      }
      case None => drinksPriceWithoutDiscount + pizzaPriceWithoutDiscount
    }
  }

  override def toString: String = {
    s"""
       |Order:
       |Name: $name
       |Address: $address
       |Phone: $phone
       |Pizzas: ${
      pizzas match {
        case Some(pizzasList) => pizzasList.mkString("\n")
        case None => "---"
      }
    }
       |Drinks: ${
      drinks match {
        case Some(drinksList) => drinksList.mkString("\n")
        case None => "---"
      }
    }
       |Discount: ${discount.getOrElse("0%")}
       |Special Info: ${specialInfo.getOrElse("None")}
       |""".stripMargin
  }

  def extraMeatPrice: Option[Double] = pizzas match {
    case Some(pizzaList) => Option(pizzaList.map(_.meatCost).sum)
    case None => None
  }

  def pizzasPrice: Option[Double] = pizzas match {
    case Some(pizzasList) => Option(pizzasList.map(_.price).sum)
    case None => None
  }

  def drinksPrice: Option[Double] = drinks match {
    case Some(drinksList) => Option(drinksList.map(_.price).sum)
    case None => None
  }

  def priceByType(pizzaType: PizzaType): Option[Double] = pizzas match {
    case Some(pizzasList) => Option(pizzasList.filter(_.pizzaType == pizzaType).map(_.price).sum)
    case None => None
  }

}
