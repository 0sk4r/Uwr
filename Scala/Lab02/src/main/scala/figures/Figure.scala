package figures

abstract class Figure {
  def area: Double

  def description: String

}

object helper {
  def areaSum(figures: List[Figure]): Double = {
    (for (figure <- figures) yield figure.area).sum
  }

  def printAll(figures: List[Figure]): Unit = {
    for (figure <- figures) println(figure.description)
  }
}

