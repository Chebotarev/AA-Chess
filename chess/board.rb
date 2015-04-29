require 'colorize'
require_relative 'piece'
require 'byebug'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }

    populate_board
  end

  def move(start_pos, end_pos)
    # debugger
    raise ArgumentError unless piece_at(start_pos)
    current_piece = piece_at(start_pos)
    if current_piece.moves.include?(end_pos)
      self[start_pos] = nil
      self[end_pos] = current_piece
      current_piece.pos = end_pos
    else
      raise "Can't move that piece there"
    end
  end

  def [](pos)
    @grid[pos.first][pos.last]
  end

  def []=(pos, piece)
    @grid[pos.first][pos.last] = piece
  end

  def on_board?(pos)
    # pos.any? { |el| el.between?(0, 7) }
    (pos[0]).between?(0, 7) && (pos[1]).between?(0, 7)
  end

  def occupied?(pos)
    !!self[pos]
  end

  def piece_at(pos)
    self[pos]
  end

  def checkmate?(color)
  end

  def check?(color)
  end

  def deep_dup
  end

  def each_space(&do_to)
    @grid.each_index do |i|
      @grid[i].each_index do |j|
        do_to.call(i, j, @grid[i][j])
      end
    end
  end

  def render
    system('clear')
    print "  "
    8.times { |x| print " #{x} "}
    puts "\n"
    each_space do |i, j, value|
      print "#{i} " if j == 0
      if value.nil?
        print "   ".green.on_red
      else
        if self[[i, j]].color == :white
          print " #{@grid[i][j].symbol} ".white.on_red
        else
          print " #{@grid[i][j].symbol} ".black.on_red
        end
      end
      puts if j == 7
    end
  end

  def populate_board
    @grid[1].map!.with_index do |space, i|
      Pawn.new(self, :white, [1, i])
    end

    @grid[0].map!.with_index do |space, i|
      case i
      when 0
        Rook.new(self, :white, [0, i])
      when 1
        Knight.new(self, :white, [0, i])
      when 2
        Bishop.new(self, :white, [0, i])
      when 3
        King.new(self, :white, [0, i])
      when 4
        Queen.new(self, :white, [0,i])
      when 5
        Bishop.new(self, :white, [0, i])
      when 6
        Knight.new(self, :white, [0, i])
      when 7
        Rook.new(self, :white, [0, i])
      end
    end

    @grid[7].map!.with_index do |space, i|
      case i
      when 0
        Rook.new(self, :black, [7, i])
      when 1
        Knight.new(self, :black, [7, i])
      when 2
        Bishop.new(self, :black, [7, i])
      when 3
        King.new(self, :black, [7, i])
      when 4
        Queen.new(self, :black, [7,i])
      when 5
        Bishop.new(self, :black, [7, i])
      when 6
        Knight.new(self, :black, [7, i])
      when 7
        Rook.new(self, :black, [7, i])
      end
    end

    @grid[6].map!.with_index do |space, i|
      Pawn.new(self, :black, [6, i])
    end

  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.render
end
