notatnik = Hash.new('osoba nie istnieje')

def dodajOsobe(notatnik)
  puts 'Imie/nick: '
  imie = gets.chomp

  puts 'Nr telefonu: '
  telefon = gets.chomp

  puts 'Grupy: '
  grupy = gets.chomp.split(' ')

  notatnik[imie] = [telefon, grupy]
end

def szukaj(notatnik)
  puts 'Podaj imie: '
  imie = gets.chomp
  dane = notatnik[imie]

  puts 'Imie: ',imie
  puts 'Nr. telefonu', dane[0]
  print 'Grupy: ', dane[1]
  puts
end

def grupy(notatnik)
  grupy = []
  notatnik.each do |imie, dane|
    grupy = grupy | dane[1]
  end
  print grupy
  puts
end

def czlonkowieGrupy(notatnik)
  puts 'Podaj grupe'
  grupa = gets.chomp
  notatnik.each do |imie, dane|
    if dane[1].include?(grupa)
      puts imie
    end
  end
end

notatnik["Oskar"]=['12345',['grupa1','grupa2']]
notatnik["Tomasz"]=['312412',['grupa2','grupa3']]

while 1
  puts 'Co chcesz zrobic?
        1. Dodaj osobe
        2. Wyszukaj
        3. Pokaz grupy
        4. Osoby nalezace do grupy
        5. Wyjście'
  
  opcja = gets.chomp

  case opcja
    when '1'
      dodajOsobe(notatnik)
    when '2'
      szukaj(notatnik)
    when '3'
      grupy(notatnik)
    when '4'
      czlonkowieGrupy(notatnik)
    when '5'
      exit
  end
end