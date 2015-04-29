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

   while (pos[0] + dir[0]).between?(0, 7) &&
                              (pos[1] + dir[1]).between?(0, 7)

      pos[0] += dir[0]
      pos[1] += dir[1]
      positions << pos.dup
    end

    positions
  end
end
