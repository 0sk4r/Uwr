require 'drb/drb'
require 'thread'
class Server
  def cpu
    data = Hash.new
    data[:cpuModel] = %x(wmic cpu get name).split
    data[:cpuUsage] = %x(wmic cpu get loadpercentage).split[1]
    return data
  end

  def ram
    data = Hash.new
    data[:totalRam] = %x(wmic ComputerSystem get TotalPhysicalMemory).split[1]
    data[:freeRam] = %x(wmic OS get FreePhysicalMemory).split[1]
    return data
  end

  def disk
    data = Hash.new
    data[:totalSpace] = %x(fsutil volume diskfree c:).split[12]
    data[:freeSpace] = %x(fsutil volume diskfree c:).split[6]
    return data
  end

  def Server.run
    @server = Server.new
    DRb.start_service('druby://localhost:1234', @server)
    DRb.thread.join
  end
end

Server.run