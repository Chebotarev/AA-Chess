require_relative 'board'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    while true
      

      begin
        board.render
        puts "Enter your start position"
        start_pos = gets.chomp.split.map(&:to_i)
        puts "Enter your end position"
        end_pos = gets.chomp.split.map(&:to_i)

        @board.move(start_pos, end_pos)
      rescue
        puts "Error!"

      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
