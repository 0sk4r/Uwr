package actions

import plugins._

import scala.annotation.tailrec

object actions {
  val actionA: Pluginable = new Pluginable with Shortening with Doubling with SingleSpacing

  val actionB: Pluginable = new Pluginable with Doubling with Shortening with NoSpacing

  val actionC: Pluginable = new Pluginable with Doubling with LowerCasing

  val actionD: Pluginable = new Pluginable with Rotating with DuplicationRemoval

  val actionE: Pluginable = new Pluginable with Reverting with Doubling with Shortening with NoSpacing

  val actionF: Pluginable = new Pluginable {
    override def plugin(text: String): Option[String] = Option(text) match {
      case Some(string) => repeat(string, 5)
      case None => None
    }

    val rotator = new Pluginable with Rotating

    @tailrec
    private def repeat(text: String, i: Int): Option[String] = {
      if(i==0) Option(text)
      else
        rotator.plugin(text) match {
          case Some(string) => repeat(string, i-1)
          case None => None
        }
    }
  }
  val actionG: Pluginable = new Pluginable {
    override def plugin(text: String): Option[String] = {
      actionA.plugin(text) match {
        case Some(string) => actionB.plugin(string)
        case None => None
      }
    }
  }

}
