require_relative 'board.rb'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.board.render
end
