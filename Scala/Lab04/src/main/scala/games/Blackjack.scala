package games

import cards.Card
import deck.Deck

class Blackjack(deck: Deck) {
  def get_cards(): List[Card] = {
    deck.get_cards()
  }

  def points(card: Card): Int = {
    var sum = 0

    if (card.getFace == "Ace") {
      println("Ace choose number of points 1 or 11")
      val value = scala.io.StdIn.readLine()
      sum += value.toInt
      println(s"$card / points: $value")
    } else {
      if (List("2", "3", "4", "5", "6", "7", "8", "9", "10").contains(card.getFace)) {
        card.getFace.toInt
      } else if (List("Jack", "Queen", "King").contains(x.get_value())) {
        sum += 10
      } else {
        sum +=11
      }
    }
    sum
  }


  def play(n: Int): Unit = {
    require(n <= deck.getCards.length, "There is no enough cards in deck")
    var sum = 0

    val cardsList = deck.getCards

    for (i <- 0 until n) {
      val card = cardsList(i)
      sum += points(card)
    }
    println("Sum of points: " + sum)
  }


//  lazy val all21: List[List[Card]] = {
//
//    def points_sum(ls: List[Card]): Int = {
//      ls.map(x => this.points(x)).sum
//    }
//
//    (0 to deck.get_cards().length).iterator.flatMap(i => deck.get_cards().combinations(i)).filter(x => points_sum(x) == 21).toList
//  }
//
//  def first21(): Unit = {
//    if(all21.nonEmpty){
//      println(all21(0))
//    }else{
//      println("no subsequences with 21 points")
//    }
//  }
}
