package figures

class Rectangle(a: Point, b: Point, c: Point, d: Point) extends Figure {

  def area: Double = {
    val x: Double = math.sqrt(math.pow((a.x - b.x).to_float, 2) + math.pow((b.y - a.y).to_float, 2))
    val y: Double = math.sqrt(math.pow((a.x - c.x).to_float, 2) + math.pow((c.y - a.y).to_float, 2))

    x * y

  }

  def description: String = "Rectangle"
}
