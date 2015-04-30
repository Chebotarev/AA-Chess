class Piece
  attr_reader :color
  attr_accessor :pos, :moved

  def initialize(params)
    @board = params[:board]
    @color = params[:color]
    @pos = params[:pos]
    @moved = false
  end

  def symbol
    raise NotImplementedError.new ("No symbol!")
  end

  def dup(dup_board)
    self.class.new(board: dup_board, color: @color, pos: @pos.dup)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(move)
    duped_board = @board.deep_dup
    duped_board.move!(self.pos, move)
    duped_board.in_check?(@color)
  end

  def sum_positions(pos1, pos2)
    [pos1.first + pos2.first, pos1.last + pos2.last]
  end
end
