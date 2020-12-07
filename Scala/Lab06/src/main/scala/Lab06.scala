import pizzeria._
import pizzeria.orders._
import pizzeria.options._

object Lab06 {
  def main(args: Array[String]): Unit = {
    val pizza1 = Pizza(Margarita, Large, Thick, Option(List(Salami, Salami)), None)
    val pizza2 = Pizza(Funghi, Small, Thin, None, Option(List(Garlic, Ketchup)))
    val pizza3 = Pizza(Margarita, Small, Thin, Option(List(Salami)), Option(List(Garlic, Ketchup)))

    val order1 = new Order("Oskar", "Kwiatkowa 1", "123456789", Option(List(pizza1, pizza2)), None, None, None)
    val order2 = new Order("Agata", "Wroclawska 21", "987654321", Option(List(pizza1, pizza2, pizza3)),
      Option(List(Lemonade)), Option(Student), None)
    val order3 = new Order("Agata", "Wroclawska 21", "987654321", Option(List(pizza1, pizza2, pizza3)),
      Option(List(Lemonade)), Option(Senior), None)

    println(order1)
    println(order2)
    println(s"Extra meat price: ${order2.extraMeatPrice.get}")
    println(s"Pizzas price: ${order2.pizzasPrice.get}")
    println(s"Drinks price: ${order2.drinksPrice.get}")
    println(s"Margherita price: ${order2.priceByType(Margarita)}")
    println(s"Total price with discount ${order2.price}")
    println(s"Total price of order 3: ${order3.price}")
  }
}
