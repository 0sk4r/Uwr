object List01 {

  def scalarUgly(xs: List[Int], ys: List[Int]) = {
    var scalar: Int = 0;
    var i: Int = 0;

    do {
      scalar += xs(i) * ys(i);
      i += 1;
    } while (i < xs.length)

    scalar
  }

  def scalar(xs: List[Int], ys: List[Int]) = {
    (for { i <- 0 until xs.length } yield xs(i) * ys(i)).sum
  }

  def sortUgly(xs: List[Int]): List[Int] = {
    if (xs.length < 2) {
      xs
    } else {
      var pivot_num: Int = xs.length / 2
      var pivot: Int = xs(pivot_num)
      var i: Int = 0
      var left_list: List[Int] = List()
      var right_list: List[Int] = List()
      var mid_list: List[Int] = List()

      do {
        if (xs(i) != pivot) {
          if (xs(i) < pivot) {
            left_list = left_list :+ xs(i)
            i += 1
          } else {
            right_list = right_list :+ xs(i)
            i += 1
          }
        } else {
          mid_list = mid_list :+ xs(i)
          i += 1
        }
      } while (i < xs.length)
      sortUgly(left_list) ::: mid_list ::: sortUgly(right_list)
    }
  }
  def sort(xs: List[Int]): List[Int] = {
    if (xs.length < 2) xs
    else {
      val pivot_num: Int = xs.length / 2
      val pivot: Int = xs(pivot_num)
      val left = xs filter (pivot > _)
      val middle = xs filter (pivot == _)
      val right = xs filter (pivot < _)
      sort(left) ::: middle ::: sort(right)
    }
  }

  import scala.math.sqrt
  def isPrimeUgly(n: Int): Boolean = {
    if (n < 2) false
    for (i <- 2 until sqrt(n).toInt) {
      if (n % i == 0) {
        return false
      }
    }
    return true
  }

  def isPrime(n: Int): Boolean = {
    if (n < 2) false
    (2 to sqrt(n).toInt) forall (n % _ != 0)
  }

  // def primePairsUgly(n: Int): List[(Int, Int)] = {

  // }
  def primePairs(n: Int): List[(Int, Int)] = {
    (for (x <- 1 to n; y <- x + 1 to n if (isPrime(x + y))) yield (x, y)).toList
  }

  val filesHere = new java.io.File(".").listFiles

  def fileLinesUgly(file: java.io.File): List[String] = {
    var res: List[String] = List()

    var i = io.Source.fromFile(file).getLines.size

    if (i > 0) {
      var lines = io.Source.fromFile(file).getLines()
      do {
        res = res :+ lines.next
        i -= 1
      } while (i > 0)
    }
    res
  }

  def fileLines(file: java.io.File): List[String] = {
    (for (line <- io.Source.fromFile(file).getLines) yield line).toList
  }

  def printNonEmptyUgly(pattern: String): Unit = {
    var i = 0
    do {
      if (filesHere(i).getName.matches(pattern) && filesHere(i).length != 0) {
        println(filesHere(i).getName)
      }
      i += 1
    } while (i < filesHere.length)
  }

  def printNonEmpty(pattern: String): Unit = {
    for (file <- filesHere) {
      if (file.getName().matches(pattern) && file.length() != 0)
        println(file.getName())
    }
  }
  def main(args: Array[String]) {
    println("Scalar: ")
    println(scalarUgly(List(1, 2, 3), List(4, 5, 6)))
    println(scalar(List(1, 2, 3), List(4, 5, 6)))

    println("Sort: ")
    println(sortUgly(List(5, 1, 5, 8, 7, 3, 2, 10, 11, 4, 0)))
    println(sort(List(5, 1, 5, 8, 7, 3, 2, 10, 11, 4, 0)))

    println("Prime:")
    println(isPrimeUgly(120))
    println(isPrimeUgly(173))

    println(isPrime(120))
    println(isPrime(173))

    println(primePairs(7))

    val file = new java.io.File("./main.scala")
    val file2 = new java.io.File("./test")

    println(fileLinesUgly(file))
    println(fileLinesUgly(file2))

    println(fileLines(file))
    println(fileLines(file2))
    printNonEmptyUgly("tes.+")
    printNonEmpty("tes.+")

  }
}
