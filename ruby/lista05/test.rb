require_relative 'zad04.rb'
require 'test/unit'

class TestLol < Test::Unit::TestCase

  def test_noargument
    assert_raise(ArgumentError) {WebPage.new('')}
  end

  def test_nolist
    assert_raise(RuntimeError) {PageMonitor.new([])}
  end

  def test_cantopen
    assert_raise(SocketError) {WebPage.new('http://unxi.wroc.pl/')}
  end
end