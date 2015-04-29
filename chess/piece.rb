class Piece
  attr_reader :color
  attr_accessor :pos

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @moved = false
  end

  def symbol
    raise NotImplementedError.new ("No symbol!")
  end

  def dup(dup_board)
    self.class.new(dup_board, @color, @pos.dup)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(move)
    duped_board = @board.deep_dup
    duped_board.move!(self.pos, move)
    duped_board.in_check?(@color)
  end
end

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

class Rook < SlidingPiece
  def symbol
    '♜'
  end

  def move_dirs
    [
      [1, 0],
      [0, 1],
      [-1, 0],
      [0, -1]
    ]
  end
end

class Bishop < SlidingPiece
  def symbol
    '♝'
  end

  def move_dirs
    [[1, 1],
    [-1, 1],
    [1, -1],
    [-1, -1]]
  end
end

class Queen < SlidingPiece
  def symbol
    '♛'
  end

  def move_dirs
    [[1, 0],
    [0, 1],
    [-1, 0],
    [0, -1],
    [1, 1],
    [-1, 1],
    [1, -1],
    [-1, -1]]
  end
end

class King < SteppingPiece
  def symbol
    '♚'
  end

  def move_diffs
    [
      [1, 1],
      [1, 0],
      [0, 1],
      [-1, 1],
      [1, -1],
      [-1, -1],
      [-1, 0],
      [0, -1]
    ]
  end
end

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
