require_relative 'piece'

class SlidingPiece < Piece

  def moves
    moves = []
    move_dirs.each do |dir|
      moves += explore(dir)
    end

    moves
  end

  def explore(dir)
    pos = @pos.dup
    positions = []

    while @board.on_board?([pos[0] + dir[0], pos[1] + dir[1]])
      pos[0] += dir[0]
      pos[1] += dir[1]
      if @board.occupied?(pos)
        if @board.piece_at(pos).color == self.color
          break
        else
          positions << pos.dup
          break
        end
      end

      positions << pos.dup
    end

    positions
  end
end
