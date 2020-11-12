object Lab02 {
  def main(args: Array[String]): Unit = {
    import numbers._
    val x = new Rational(50, 6)
    println(x)

    val x1 = new Rational(1, 2)
    val x2 = Rational.one()
    val x3 = new Rational(3, 4)
    val x4 = Rational.zero()

    println(x1 + x2)
    println(x1 * x4)
    println(x3 - x1)
    println(x3 * x1)
    println(x3 / x1)

    import figures._

    val point1 = new Point(new Rational(1, 1), new Rational(1, 1))
    val point2 = new Point(new Rational(2, 1), new Rational(2, 1))
    val point3 = new Point(new Rational(1, 1), new Rational(2, 1))
    val point4 = new Point(new Rational(2, 1), new Rational(1, 1))

    val triangle = new Triangle(point1, point2, point3)
    val rectangle = new Rectangle(point1, point2, point3, point4)
    val square = new Square(point1, point2)

    println(triangle.description)
    println(triangle.area)
    println(rectangle.description)
    println(rectangle.area)
    println(square.description)
    println(square.area)

    val figureList = List(triangle, square, rectangle)

    println(helper.areaSum(figureList))
    helper.printAll(figureList)

  }
}
