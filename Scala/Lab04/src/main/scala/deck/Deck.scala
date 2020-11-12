package deck

import cards.Card

import scala.util.Random

class Deck(cards: List[Card]) {

  def pull(): Deck = {
    require(cards.nonEmpty, "Deck is empty!")
    if (cards.nonEmpty) {
      new Deck(cards.tail)
    } else {
      new Deck(List())
    }
  }

  def push(c: Card): Deck = {
    new Deck(c :: cards)
  }

  def push(color: String, value: String): Deck = {
    new Deck(new Card(color, value) :: cards)
  }

  val isStandard: Boolean = {
    cards.distinct.length == 52
  }

  def duplicatesOfCard(card: Card): Int = {
    cards.count(card.equals(_))
  }

  def amountOfColor(color: String): Int = {
    require(List("Diamonds", "Spades", "Hearts", "Clubs").contains(color), "Wrong color argument!")
    cards.count(_.getColor == color)
  }

  def amountOfNumerical(numerical: String): Int = {
    require(List("2", "3", "4", "5", "6", "7", "8", "9", "10").contains(numerical), "Wrong numerical argument")
    cards.count(_.getFace == numerical)
  }

  val amountWithNumerical: Int = {
    cards.count(x => List("2", "3", "4", "5", "6", "7", "8", "9", "10").contains(x.getFace()))
  }

  def amountOfFace(face: String): Int = {
    require(List("King", "Queen", "Jack").contains(face), "Wrong face argument!")
    cards.count(_.getFace() == face)
  }

  val amountWithFace: Int = {
    cards.count(x => List("Jack", "Queen", "King").contains(x.getFace()))
  }

  def getCards: List[Card] = cards
}

object Deck {

  def apply(): Deck = {
    val colorsList = List("Diamonds", "Spades", "Hearts", "Clubs")
    val valueList = List("2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace")
    var deck = new Deck(List())

    for (color <- 0 to 3; value <- 0 to 12) {
      deck = deck.push(new Card(colorsList(color), valueList(value)))
    }

    new Deck(Random.shuffle(deck.getCards))
  }
}
