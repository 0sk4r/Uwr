
class Proc

  def value(x)
    self.call(x)
  end

  def zerowe(a, b, e)
    wynik = []
    for x in (a..b).step(e)
      if value(x) == 0
        wynik.push(x)
      end
    end
    return wynik if wynik != []
    nil
  end

  def pochodna(x)
    h = 0.00000000001
    return (0.0+value(x+h)-value(x))/h
  end

  def pole(a, b)

    wynik = 0.0
    n = 1000
    h = (b-a)/n

    for i in 1..n
      wartosc = value(a + (i-1)*h)
      wynik += h*wartosc
    end

    return wynik
  end

  def plot(a, b, nazwa)

    file = File.open(nazwa, "w")

    for i in (a..b).step(0.1)
      file.puts i.to_s + " " + (value(i)).to_s
    end
    file.close
  end

end

puts "f(x) = x^2 - 1"
f = proc { |x| x * x - 1 }

puts "f(2) = ", f.value(2)
puts "miejsce zerowe na [1,10] : ", f.zerowe(1, 10, 0.0001)
puts "pochodna w  5", f.pochodna(3)
puts "pole [1,2] : ", f.pole(1.0, 2.0)

f.plot(0, 10, "plik")