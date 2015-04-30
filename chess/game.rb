require_relative 'board'
require_relative 'players/human_player.rb'
require_relative 'players/computer_player.rb'

class Game
  attr_accessor :board

  def initialize(player_white, player_black)
    @board = Board.new
    @player_white = player_white
    @player_white.board = @board
    @player_black = player_black
    @player_black.board = @board
    @current_player = player_white
  end

  def right_color?(pos)

    @board[pos].color == @current_player.color
  end

  def switch_player
    if @current_player == @player_white
      @current_player = @player_black
    else
      @current_player = @player_white
    end
  end

  def game_status
    if @board.in_check?(@current_player.color)
      puts "#{@current_player.color.to_s.capitalize} is in check"
    end
    puts "#{@current_player.color.to_s.capitalize}'s turn"
  end

  def play
    until @board.won? || @board.stalemate?(@current_player.color)
      begin
        board.render
        game_status
        start_pos, end_pos = @current_player.make_move
        @board.move(start_pos, end_pos, @current_player.color)
        switch_player
      rescue MoveError => e
        puts e.message
        puts "Enter to continue"
        gets
      end
    end
    board.render
    if @board.stalemate?(@current_player.color)
      puts "Stalemate"
    else
      switch_player
      puts "#{@current_player.color.to_s.capitalize} wins!"
    end
  end



end

if __FILE__ == $PROGRAM_NAME
  player1 = ComputerPlayer.new(:white)
  player2 = HumanPlayer.new(:black)
  game = Game.new(player1, player2)
  game.play
end
