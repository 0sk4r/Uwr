import cards.Card
import deck.Deck

object Main {
  def main(args: Array[String]): Unit = {
    val card1 = new Card("Hearts", "Queen")
    val card2 = new Card("Hearts", "King")
    val card3 = new Card("Hearts", "Ace")

    val card4 = new Card("Clubs", "10")
    val card5 = new Card("Diamonds", "6")

    var deck1 = new Deck(List(card1, card2, card3))
  }
}
