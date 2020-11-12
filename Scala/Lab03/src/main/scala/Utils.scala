import scala.annotation.tailrec

object Utils {
  def isSorted(as: List[Int], ordering: (Int, Int) => Boolean): Boolean = {

    @tailrec
    def isSortedHelper(n: Int): Boolean = {
      if (n + 1 >= as.length)
        true
      else if (!ordering(as(n), as(n + 1))) false
      else
        isSortedHelper(n + 1)
    }

    isSortedHelper(0)
  }

  def isAscSorted(as: List[Int]): Boolean = {
    isSorted(as, (x: Int, y: Int) => x <= y)
  }

  def isDescSorted(as: List[Int]): Boolean = {
    isSorted(as, (x: Int, y: Int) => x >= y)
  }

  @tailrec
  def foldLeft[A, B](l: List[A], z: B)(f: (B, A) => B): B = {
    l match {
      case x :: y => foldLeft(y, f(z, x))(f)
      case Nil => z
    }
  }

  def sum(l: List[Int]): Int = {
    foldLeft(l, 0)((a, b) => a + b)
  }

  def length[A](l: List[A]): Int = {
    foldLeft(l, 0)((iter, _) => iter + 1)
  }

  def compose[A, B, C](f: B => C, g: A => B): A => C = {
    a: A => f(g(a))
  }

  def repeated[A, B](fun: A => A, n: Int): A => A = {

    @tailrec
    def repeatedHelper(fun: A => A, acc: A => A, n: Int): A => A = {
      if (n <= 0) {
        acc
      } else {
        repeatedHelper(fun, compose(fun, acc), n - 1)
      }
    }

    repeatedHelper(fun, fun, n)
  }

  def curry[A, B, C](f: (A, B) => C): A => B => C = {
    a: A => (b: B) => f(a, b)
  }

  def uncurry[A, B, C](f: A => B => C): (A, B) => C = {
    (a: A, b: B) => f(a)(b)
  }

  def unSafe[T](ex: Exception)(code: => T): T = {
    try {
      code
    } catch {
      case x: Exception => println(x); throw ex
    }
  }
}
