import Money._

object Lab07 {
  def main(args: Array[String]): Unit ={

    val sum1: Money = 100.01(USD) + 200(EUR)
    println(s"Sum1 100.01 USD + 200 EURO = ${sum1}")

    val sum2: Money = 100.01(zl) + 200($)
    println(s"Sum2 100.01 zl + 200 USD = ${sum2}")

    val sum3: Money = 5(zl) + 3(PLN) + 20.5(USD)
    println(s"Sum3 5 zl + 3 PLN + 20.5 USD = ${sum3}")

    val sub: Money = 300.01(USD) - 200(EUR)
    println(s"Sub 300 USD - 200 EUR = ${sub}")

    val mult1: Money = 30(zl) * 20
    println(s"Mult1 30 zl * 20 = ${mult1}")

    val mult2: Money = 20($) * 11
    println(s"Mult2 20 USD * 11 = ${mult2}")

    val conv1: Money = 150.01(USD) as PLN
    println(s"Conv1 150.01 USD to PLN = ${conv1}")

    val conv2: Money = 120.01(USD) as eu
    println(s"Conv2 120.01 USD to EUR = ${conv2}")


    val compare1: Boolean = 300.30(USD) > 200(eu)
    println(s"Compare1 300 USD > 200 EUR = ${compare1}")

    val compare2: Boolean = 300.30($) < 200(EUR)
    println(s"Compare2 300.30 USD < 200 EUR= ${compare2}")

    val long1: Money = 300(PLN) + 10(PLN) * 10 - 10(PLN)
    println(s"300 PLN + 10 PLN * 10 PLN - 10PLN = ${long1}")
  }
}
