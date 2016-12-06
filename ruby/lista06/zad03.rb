require 'sqlite3'

class Notepad
  def initialize
    puts '1) Stworz db 2) Otworz db'
    x = gets.chomp
    if x == '1'
      puts 'Utworz db: '
      x = gets.chomp
      newDB(x)
    else
      puts 'Otworz db: '
      x = gets.chomp
      @db = SQLite3::Database.open x
    end
  end

  def newDB(name)
    @db = SQLite3::Database.new(name)
    @db.execute "CREATE TABLE IF NOT EXISTS Notepad(Name TEXT, Phone INT, Email TEXT, Nick TEXT)"
    puts 'Create DB: ' + name
  end

  def addPerson()
    puts 'Podaj: imie, telefon, email, nick'
    x = gets.chomp
    @name, @phone, @email, @nick = x.split(',')
    exist = @db.execute "SELECT * FROM Notepad WHERE Name = '#{@name}'"
    if exist == []
      @db.execute "INSERT INTO Notepad (Name, Phone, Email, Nick) VALUES ( '#{@name}', #{@phone}, '#{@email}','#{@nick}')"
    else
      puts 'This person already exist'
    end
  end

  def delPerson()
    puts 'Podaj imie do usuniecia'
    name = gets.chomp
    @db.execute "DELETE FROM Notepad WHERE Name = '#{name}'"
  end

  def show()
    data = @db.execute "SELECT * FROM Notepad"
    data.each { |line|
      puts "Name: #{line[0]}"
      puts "Phone: #{line[1]}"
      puts "Email: #{line[2]}"
      puts "Nick: #{line[3]}"
      puts '==============================================='
    }
  end

  def findPerson()
    puts 'Podaj imie: '
    name = gets.chomp
    data = @db.execute "SELECT * FROM Notepad WHERE Name = '#{name}'"
    if data != []
      puts "Name: #{data[0][0]}"
      puts "Phone: #{data[0][1]}"
      puts "Email: #{data[0][2]}"
      puts "Nick: #{data[0][3]}"
    else
      puts 'Nie ma takiej osoby!'
    end


  end
end

db = Notepad.new

while 1
  puts 'Co chcesz zrobic:'
  puts '1) Dodaj osobe'
  puts '2) Usun osobe'
  puts '3) Pokaz osby'
  puts '4) Szukaj osoby'
  puts '5) Zakoncz'

  x = gets.chomp
  case x
    when '1'
      db.addPerson
    when '2'
      db.delPerson
    when '3'
      db.show
    when '4'
      db.findPerson
    when '5'
      break
  end
end