require_relative 'stepping_piece'

class Knight < SteppingPiece
  def symbol
    '♞'
  end

  def move_diffs
    [
      [1, 2],
      [2, 1],
      [-1, 2],
      [2, -1],
      [-1, -2],
      [-2, -1],
      [-2, 1],
      [1, -2]
    ]
  end
end
