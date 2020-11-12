import Utils._

object Lab02 {
  def main(args: Array[String]): Unit = {
    println("Is sorted:")
    println(isAscSorted(List(1, 1, 2, 3, 10, 11)))
    println(isDescSorted(List(1, 1, 2, 3, 10, 11)))

    println("Sum")
    println(sum(List(1, 2, 3, 4, 5)))

    println("Length")
    println(length(List(1, 2, 3, 4, 5)))

    def fun(x: Int): Int = x * 2

    val repeat3 = repeated(fun, 3)

    println("repeat")
    println(repeat3(5))

    def increase(x: Int): Int = x + 1

    println("Compose")
    val compose1 = compose(fun, increase)
    println(compose1(2))

    println("Curry, uncurry")

    def f1(x: Int, y: Int) = x * y

    val curryFun = curry(f1)
    println(curryFun(2)(3))

    val uncurryFun = uncurry(curryFun)
    println(uncurryFun(2, 3))

    println("Custom exception")

    unSafe(MyCustomException("Something broke")) {
      if (1 / 0 > 0) {
        println("success")
      } else {
        println("error")
      }
    }
  }
}

final case class MyCustomException(msg: String) extends Exception