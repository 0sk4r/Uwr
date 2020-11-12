package figures

class Square(a: Point, b: Point) extends Figure {
  def area: Double = {
    math.sqrt(math.pow((a.x - b.x).to_float, 2) + math.pow((b.y - a.y).to_float, 2))
  }

  def description: String = "Square"

}
