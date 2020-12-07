package object Money {

  val conversion: Map[(Currency, Currency), BigDecimal] = Map(
    (EUR, PLN) -> 4.48,
    (EUR, USD) -> 1.20,
    (USD, EUR) -> 0.84,
    (USD, PLN) -> 3.75,
    (PLN, USD) -> 0.27,
    (PLN, EUR) -> 0.22
  )

    val symbolConversion: Map[Symbol, Currency] = Map(
      $ -> USD,
      zl -> PLN,
      eu -> EUR
      // I have problem with encoding of euro symbol
    )

  trait Currency
  case object USD extends Currency
  case object PLN extends Currency
  case object EUR extends Currency

  trait Symbol
  case object $ extends Symbol
  case object zl extends Symbol
  case object eu extends Symbol

  case class CurrencyConverter(conversion: Map[(Currency, Currency), BigDecimal]) {
    def convert(from: Money, to: Currency): BigDecimal = {
      if (from.currency == to) {
        from.amount
      } else {
        from.amount * this.conversion((from.currency, to))
      }
    }
  }

  implicit class numberToMoney(val value: Double) {
    def apply(currency: Currency): Money = currency match {
      case cur: Currency => Money(value, currency)(CurrencyConverter(conversion))
      case _ => throw new Exception("Unknown currency")
    }
  }

  implicit def symbolToCurrency(symbol: Symbol): Currency = symbol match {
    case sym: Symbol => symbolConversion(sym)
    case _ => throw new Exception("Unknown symbol")
  }

  case class Money(amount: BigDecimal, currency: Currency)(implicit currencyConverter: CurrencyConverter) {

    def +(y: Money): Money = Money(this.amount + y.as(this.currency).amount, this.currency)

    def -(y: Money): Money = Money(this.amount - y.as(this.currency).amount, this.currency)

    def *(y: BigDecimal): Money = Money(this.amount * y, this.currency)

    def as(y: Currency): Money = Money(currencyConverter.convert(this, y), y)

    def >(y: Money): Boolean = this.amount > currencyConverter.convert(y, this.currency)

    def <(y: Money): Boolean = this.amount < currencyConverter.convert(y, this.currency)

    override def toString: String = s"${this.amount}(${this.currency})"
  }
}
