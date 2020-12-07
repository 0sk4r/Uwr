import actions._
import plugins.{Doubling, DuplicationRemoval, LowerCasing, NoSpacing, Pluginable, Reverting, Rotating, Shortening, SingleSpacing}

object Main {
  def main(args: Array[String]): Unit = {
    val t1 = "abc"
    val pluginRevert = new Pluginable with Reverting
    println(s"Reverting $t1 = ${pluginRevert.plugin(t1).get}")

    val t2 = "aAbC AA dd Dca"
    val pluginLowerCasing = new Pluginable with LowerCasing
    println(s"Lower casing $t2 = ${pluginLowerCasing.plugin(t2).get}")

    val t3 = "ala ma  kota"
    val pluginSingleSpacing = new Pluginable with SingleSpacing
    println(s"Single spacing $t3 = ${pluginSingleSpacing.plugin(t3).get}")

    val t4 = "ala ma    kota"
    val pluginNoSpacing = new Pluginable with NoSpacing
    println(s"No spacing $t4 = ${pluginNoSpacing.plugin(t4).get}")

    val t5 = "alzaa  cda"
    val pluginDuplicationRemoval = new Pluginable with DuplicationRemoval
    println(s"Duplication removal $t5 = ${pluginDuplicationRemoval.plugin(t5).get}")

    val t6 = "abc"
    val pluginRotation = new Pluginable with Rotating
    println(s"Rotation $t6 = ${pluginRotation.plugin(t6).get}")

    val t7 = "abcd"
    val pluginDoubling = new Pluginable with Doubling
    println(s"Doubling $t7 = ${pluginDoubling.plugin(t7).get}")

    val t8 = "ab cd"
    val pluginShortening = new Pluginable with Shortening
    println(s"Shortening $t8 = ${pluginShortening.plugin(t8).get}")

    val t9 = "Ala ma  kOta"
    println(s"actionA = ${actions.actionA.plugin(t9).get}")
    println(s"actionB = ${actions.actionB.plugin(t9).get}")
    println(s"actionC = ${actions.actionC.plugin(t9).get}")
    println(s"actionD = ${actions.actionD.plugin(t9).get}")
    println(s"actionE = ${actions.actionE.plugin(t9).get}")
    println(s"actionF = ${actions.actionF.plugin(t9).get}")
    println(s"actionG = ${actions.actionG.plugin(t9).get}")





  }
}