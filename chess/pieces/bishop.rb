class Bishop < SlidingPiece
  def symbol
    "B"
  end

  def move_dirs
    [[1, 1],
     [-1, 1],
     [1, -1],
     [-1, -1]]
  end
end
