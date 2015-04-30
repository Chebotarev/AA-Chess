require_relative 'piece'

class Pawn < Piece
  NORMAL_MOVE = [1, 0]
  INITIAL_MOVE = [2, 0]
  ATTACK_MOVES = [[1, 1], [1, -1]]


  def symbol
    '♟'
  end

  def moves
    moves = []
    modifier = self.color == :white ? 1 : -1

    normal_move = sum_positions(NORMAL_MOVE.map { |move| move * modifier }, @pos)
    unless @board.occupied?(normal_move)
      moves << normal_move
    end

    initial_move = sum_positions(INITIAL_MOVE.map { |move| move * modifier }, @pos)
    if !@moved && moves.include?(normal_move) && !@board.occupied?(initial_move)
      moves << initial_move
    end

    ATTACK_MOVES.each do |attack_move|
      potential_pos = sum_positions(@pos.dup, attack_move.map { |move| move * modifier })
      if @board.occupied?(potential_pos) && @board.piece_at(potential_pos).color != @color
        moves << potential_pos
      end
    end

    moves.select { |move| @board.on_board?(move)}
  end
end
