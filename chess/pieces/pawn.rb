require_relative 'piece'

class Pawn < Piece
  def symbol
    '♟'
  end

  def moves
    moves = []
    modifier = self.color == :white ? 1 : -1

    [-1, 1].each do |el|
      potential_pos = [@pos.first + modifier, @pos.last + el]
      if @board.occupied?(potential_pos) &&
                 @board.piece_at(potential_pos).color != self.color
        moves << potential_pos.dup
      end
    end
    potential_pos = [@pos.first + modifier, @pos.last]

    unless @board.occupied?(potential_pos)
      moves  << potential_pos.dup
      potential_pos[0] = potential_pos.first + modifier
      unless @moved && @board.occupied?(potential_pos)
        moves << potential_pos.dup
      end
    end
    moves
  end
end
