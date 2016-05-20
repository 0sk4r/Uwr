class Jawna

  def initialize(text)
    @text = text
  end

  def to_s
    @text
  end

  def zaszyfruj(klucz)

    pom = ""

    (0..@text.length-1).each { |i|
      pom += (@text[i].ord + klucz).chr
    }

    return Zaszyfrowane.new(pom)

  end
end

class Zaszyfrowane

  def initialize(text)
    @text = text
  end

  def to_s
    @text
  end

  def odszyfruj(klucz)

    pom = ""

    (0..@text.length-1).each { |i|
      pom += (@text[i].ord - klucz).chr
    }

    return Jawna.new(pom)
  end
end

napis = Jawna.new("Ala ma kota")
zaszyfrowany = napis.zaszyfruj(3)
odszyfrowany = zaszyfrowany.odszyfruj(3)
puts napis
puts zaszyfrowany
puts odszyfrowany

