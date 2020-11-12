package figures

class Triangle(a: Point, b: Point, c: Point) extends Figure {
  def area: Double = {
    0.5 * math.abs((((b.x - a.x) * (c.y - a.y)) - (b.y - a.y) * (c.x - a.x)).to_float)
  }

  def description: String = "Triangle"
}
