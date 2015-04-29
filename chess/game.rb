require_relative 'board'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    until @board.checkmate?(:white) || @board.checkmate?(:black)
      begin
        board.render
        start_pos, end_pos = prompt_player
        @board.move(start_pos, end_pos)
      rescue MoveError => e
        puts e.message
        puts "Enter to continue"
        gets
      end
    end
  end

  def prompt_player
    puts "Enter your start position"
    start_pos = gets.chomp.split.map(&:to_i)
    puts "Enter your end position"
    end_pos = gets.chomp.split.map(&:to_i)
    [start_pos, end_pos]
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
