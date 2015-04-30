require_relative 'piece'

class SteppingPiece < Piece

  def moves
    moves = []
    move_diffs.each do |diff|
      new_pos = [@pos.first + diff.first, @pos.last + diff.last]
      next unless @board.on_board?(new_pos)
      if @board.occupied?(new_pos)
        next if @board.piece_at(new_pos).color == self.color
      end
      moves << new_pos
    end

    moves
  end
end
