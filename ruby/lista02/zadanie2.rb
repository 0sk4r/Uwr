notatnik = Hash.new('osoba nie istnieje')

def dodajOsobe(notatnik)
  puts 'Imie/nick: '
  imie = gkioets.chomp

  puts 'Nr telefonu: '
  telefon = gets.chomp

  puts 'Grupy: '
  grupy = gets.chomp.split(' ')

  notatnik[imie] = [telefon, grupy]
end

def szukaj(imie, notatnik)
  dane = notatnik[imie]

  puts 'Imie: ',imie
  puts 'Nr. telefonu', dane[0]
  puts 'Grupy: ', dane[1]

end

def grupy(notatnik)
  grupy = []
  notatnik.each do |imie, dane|
    grupy = grupy | dane[1]
  end
  print grupy
end

def czlonkowieGrupy(grupa, notatnik)
  notatnik.each do |imie, dane|
    if dane[1].include?(grupa)
      puts imie
    end
  end
end