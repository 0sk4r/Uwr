require 'thread'
require 'drb'

MEGABYTE = 1024.0 * 1024.0

class Client

  def initialize
    adressList = ['druby://localhost:1234']
    @serverList = []
    for adress in adressList
      @serverList << DRbObject.new_with_uri(adress)
    end
  end

  def getInfo(server)
    cpu = server.cpu
    ram = server.ram
    disk = server.disk
    puts "Cpu model: #{cpu[:cpuModel].join(' ')}"
    puts "Cpu usage: #{cpu[:cpuUsage]}%"
    puts "Ram total: #{ram[:totalRam].to_i / MEGABYTE} MB"
    puts "Ram free: #{ram[:freeRam].to_i/1000} MB"
    puts "Disk total: #{disk[:totalSpace].to_i/MEGABYTE} MB"
    puts "Disk free: #{disk[:freeSpace].to_i/MEGABYTE} MB"
  end

  def update
    for server in @serverList
      puts "================================================================"
      getInfo(server)
      puts "================================================================"
    end
  end

  def run
    while 1
      update
      sleep(10)
    end
  end
end


a = Client.new
a.run