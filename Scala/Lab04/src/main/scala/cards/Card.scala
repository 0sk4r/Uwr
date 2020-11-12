package cards

class Card(color: String, face: String) {
  require(List("Diamonds", "Spades", "Hearts", "Clubs").contains(color) &&
    List("2", "3", "4", "5", "6", "7", "8", "9", "10", "King", "Queen", "Ace", "Jack").contains(face), "Wrong arguments!")

  def getColor: String = {
    color
  }

  def getFace: String = {
    face
  }
}
