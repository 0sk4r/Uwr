package numbers

class Rational(n: Int, d: Int) {
  require(d > 0, "Please enter denominator greater than 0")


  private def gcd(a: Int, b: Int): Int = {
    if (b == 0) a else gcd(b, a % b)
  }

  private val divisor: Int = gcd(n, d)

  val numerator: Int = n / divisor
  val denominator: Int = d / divisor

  def this(n: Int) = this(n, 1)

  def +(other: Rational): Rational = {
    val new_numerator: Int = other.numerator * denominator + other.denominator * numerator
    val new_denominator: Int = other.denominator * denominator

    new Rational(new_numerator, new_denominator)
  }

  def -(other: Rational): Rational = {
    val new_numerator = other.denominator * numerator - other.numerator * denominator
    val new_denominator = other.denominator * denominator

    new Rational(new_numerator, new_denominator)
  }

  def *(other: Rational): Rational = {
    val new_numerator = other.numerator * numerator
    val new_denominator = other.denominator * denominator

    new Rational(new_numerator, new_denominator)
  }

  def /(other: Rational): Rational = {
    val new_numerator = other.denominator * numerator
    val new_denominator = other.numerator * denominator

    new Rational(new_numerator, new_denominator)
  }

  override def toString: String = {

    val integer: Int = numerator / denominator
    val new_numerator: Int = numerator - integer * denominator

    if (new_numerator == 0) {
      s"$integer"
    } else {
      if (integer == 0) {
        s"$new_numerator/$denominator"
      } else {
        s"$integer $new_numerator/$denominator"
      }
    }

  }

  def to_float: Double = {
    numerator / denominator
  }
}

object Rational {
  def zero(): Rational = new Rational(0)

  def one(): Rational = new Rational(1)
}
