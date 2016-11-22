require 'digest'
require 'open-uri'

class Monitor
  def initialize
    @sites = Hash.new
  end

  def addSites
    while 1
      puts 'Wpis adres lub napisz koniec: '
      x = gets.chomp
      break if x == 'koniec'
      @sites[x]=Digest::MD5.hexdigest open(x).read
    end
  end

  def checkChanges
    @sites.each_key { |key|
      checksum = Digest::MD5.hexdigest open(key).read
      if @sites[key] != checksum
        @sites[key] = checksum
        puts 'Strona #{key} zostala zmieniona'
      end
      puts 'strona'
    }
  end
end

a=Monitor.new
a.addSites
thread = Thread.new{a.checkChanges}