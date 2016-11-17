module Debug
  def check
    self.methods.grep(/^test_/) { |method| puts "#{method}: #{send(method)}" }
  end
end

class TestClass
  include Debug
  def initialize

  end
  def test_abc
    "Metoda testowa 1"
  end
  def test_123
    "Metoda testowa 2"
  end
  def abctest_
    "to nie jest test!!!"
  end
end

x = TestClass.new
puts 'Klasa X:'
x.check