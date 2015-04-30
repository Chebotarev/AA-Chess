require 'colorize'
require_relative 'pieces'
require_relative 'errors'

class Board

  attr_reader :grid

  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) }

    populate_board if setup
  end

  def move(start_pos, end_pos, color)
    raise OffBoardError unless on_board?(start_pos) && on_board?(end_pos)
    raise NoPieceError unless piece_at(start_pos)
    raise WrongColorError unless piece_at(start_pos).color == color

    current_piece = piece_at(start_pos)
    if current_piece.valid_moves.include?(end_pos)
      move!(start_pos, end_pos)
    else
      raise InvalidMoveError
    end
  end

  def move!(start_pos, end_pos)
    current_piece = piece_at(start_pos)
    self[start_pos] = nil
    self[end_pos] = current_piece
    current_piece.pos = end_pos
    current_piece.moved = true
  end

  def [](pos)
    @grid[pos.first][pos.last]
  end

  def []=(pos, piece)
    @grid[pos.first][pos.last] = piece
  end

  def on_board?(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

  def occupied?(pos)
    return false unless on_board?(pos)
    !!self[pos]
  end

  def won?
    checkmate?(:white) || checkmate?(:black)
  end

  def stalemate?(color)
    pieces(color).all? { |piece| piece.valid_moves.empty? } && !in_check?(color)
  end

  def piece_at(pos)
    self[pos]
  end

  def checkmate?(color)
    pieces(color).all? { |piece| piece.valid_moves.empty? } &&
    in_check?(color)
  end

  def in_check?(color)
    opponent_color = color == :white ? :black : :white
    king_pos = king(color).pos
    pieces(opponent_color).any? do |piece|
      piece.moves.include?(king_pos)
    end
  end

  def deep_dup
    dup_board = Board.new(false)

    [:white, :black].each do |color|
      pieces(color).each do |piece|
        duped_piece = piece.dup(dup_board)
        dup_board[duped_piece.pos] = duped_piece
      end
    end

    dup_board
  end

  def render
    system('clear')
    print "  " + ('a'..'h').to_a.join(" ") + "\n"
    self.grid.each_with_index do |row, i|
      print "#{i + 1} "
      row.each_with_index do |space, j|
        if (i + j).odd?
          if space.nil?
            print "  ".on_red
          else
            if space.color == :white
              print "#{space.symbol} ".white.on_red
            else
              print "#{space.symbol} ".black.on_red
            end
          end
        else
          if space.nil?
            print "  ".on_blue
          else
            if space.color == :white
              print "#{space.symbol} ".white.on_blue
            else
              print "#{space.symbol} ".black.on_blue
            end
          end
        end
      end
      print " #{i + 1}"
      puts
    end
    print "  " + ('a'..'h').to_a.join(" ") + "\n"
  end
  # end

  def king(color)
    pieces(color).find { |piece| piece.is_a?(King)}
  end

  def pieces(color)
    pieces = @grid.flatten.compact
    pieces.select { |piece| piece.color == color}
  end

  def populate_board
    # Stalemate test case
    # @grid[0][7] = King.new(self, :black, [0,7])
    # @grid[2][6] = Queen.new(self, :white, [2,6])
    # @grid[2][5] = King.new(self, :white, [2, 5])

    [[1,:white], [6, :black]].each do |row|
      @grid[row.first].map!.with_index do |space, i|

        Pawn.new(board: self, color: row.last, pos: [row.first, i])
      end
    end

    [[0, :white], [7, :black]].each do |row|
      @grid[row.first].map!.with_index do |space, i|
        params = { board: self, color: row.last, pos: [row.first, i] }
        case i
        when 0
          Rook.new(params)
        when 1
          Knight.new(params)
        when 2
          Bishop.new(params)
        when 3
          King.new(params)
        when 4
          Queen.new(params)
        when 5
          Bishop.new(params)
        when 6
          Knight.new(params)
        when 7
          Rook.new(params)
        end
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.render
end
