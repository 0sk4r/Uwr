require_relative 'zad04.rb'

begin

  pages1 = ["http://uni.wroc.pl/","http://google.com/"]
  pages2 = ["http://www.interia.pl/","http://stackoverflow.com"]
  threads = []


  threads << Thread.new() {PageMonitor.new(pages1,'plik1').startMonitor}
  threads << Thread.new() {PageMonitor.new(pages2,'plik2').startMonitor}


  threads.each {|thread| thread.join}

end