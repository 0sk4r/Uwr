require 'digest'
require 'open-uri'
require 'yaml'
require 'socket'

class WebPage
  attr_accessor :hash

  def initialize url
    raise ArgumentError, "No argument" if url == ''

    @url = url
    @source = open(url, &:read)
    @hash = Digest::SHA256.digest @source
  end

  def == a
    @hash == a.hash
  end
end

class PageMonitor

  def initialize(tab = [], file)
    @mFile = File.expand_path("../#{file}.yml", __FILE__)
    @pages = File.file?(@mFile) ? YAML.load_file(@mFile) : Hash.new

    tab.delete_if{|u| @pages.has_key? u}.each{|a| puts "Added: #{a}"; @pages[a] = WebPage.new(a)}
    raise RuntimeError, "List is empty" if @pages.empty?
  end

  def startMonitor
    while true do
      @pages.each do |url, page|
        p = WebPage.new url
        if p != page
          puts "Content of #{url} was changed"
          @pages[url] = p
          save
        end
      end
      sleep 10
    end
  end

  def save
    File.open(@mFile, "w"){|f| f.write @pages.to_yaml}
  end
end


