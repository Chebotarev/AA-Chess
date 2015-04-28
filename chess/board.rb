require 'colorize'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) do |i|
      Array.new(8) do |j|
        nil
      end
    end
  end

  def each_space(&do_to)
    @grid.each_index do |i|
      @grid[i].each_index do |j|
        do_to.call(i, j)
      end
    end
  end

  def render
    system('clear')
    each_space do |i, j|
      print " #{@grid[i][j]} ".green.on_red
      puts if j == 7
    end
  end
end
