package plugins

import scala.annotation.tailrec

abstract class Pluginable {
  def plugin(text: String): Option[String] = Option(text)
}

trait Reverting extends Pluginable {
  override def plugin(text: String): Option[String] = Option(text) match {
    case Some(string) => super.plugin(string.reverse)
    case None => None
  }

}

trait LowerCasing extends Pluginable {
  override def plugin(text: String): Option[String] = Option(text) match {
    case Some(string) => super.plugin(string.toLowerCase)
    case None => None
  }
}

trait SingleSpacing extends Pluginable {
  override def plugin(text: String): Option[String] = Option(text) match {
    case Some(string) => super.plugin(string.replaceAll(" +", " "))
    case None => None
  }
}

trait NoSpacing extends Pluginable {
  override def plugin(text: String): Option[String] = Option(text) match {
    case Some(string) => super.plugin(string.replaceAll("\\s", ""))
    case None => None
  }
}

trait DuplicationRemoval extends Pluginable {
  override def plugin(text: String): Option[String] = Option(text) match {
    case Some(string) => super.plugin(duplicationRemovalHelper(string.toList))
    case None => None
  }

  private def duplicationRemovalHelper(text: List[Char]): String = text match {
    case x :: xs =>
      if (xs.contains(x)) duplicationRemovalHelper(xs.filter(_ != x))
      else x + duplicationRemovalHelper(xs)
    case Nil => ""
  }
}

trait Rotating extends Pluginable {
  override def plugin(text: String): Option[String] = Option(text) match {
    case Some(string) => super.plugin(string.takeRight(1) + string.dropRight(1))
    case None => None
  }
}

trait Doubling extends Pluginable {
  override def plugin(text: String): Option[String] = Option(text) match {
    case Some(string) => super.plugin(doublingHelper(string.toList, "", 0))
    case None => None
  }

  @tailrec
  private def doublingHelper(text: List[Char], temp: String, i: Int): String = text match {
    case x :: xs =>
      if (i % 2 == 0) doublingHelper(xs, temp + x, i + 1)
      else doublingHelper(xs, temp + x + x, i + 1)
    case Nil => temp
  }
}

trait Shortening extends Pluginable {
  override def plugin(text: String): Option[String] = Option(text) match {
    case Some(string) => super.plugin(shorteningHelper(string.toList, 0))
    case None => None
  }

  private def shorteningHelper(text: List[Char], i: Int): String = text match {
    case x :: xs =>
      if (i % 2 != 0) shorteningHelper(xs, i + 1) else x + shorteningHelper(xs, i + 1)
    case Nil => ""
  }
}