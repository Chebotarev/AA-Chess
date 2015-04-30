require 'byebug'
class ComputerPlayer
  attr_reader :color
  attr_writer :board

  def initialize(color)
    @color = color
  end

  def make_move
    valid_moves_hash = {}
    @board.pieces(@color).each do |piece|
      valid_moves_hash[piece.pos] = piece.valid_moves unless piece.valid_moves.empty?
    end
    rand_key = valid_moves_hash.keys.sample
    random_move = [rand_key, valid_moves_hash[rand_key].sample]

    good_moves = []
    valid_moves_hash.each_pair do |start_pos, potential_positions|
      potential_positions.each do |potential_pos|
        good_moves << [start_pos, potential_pos] if @board.piece_at(potential_pos)
      end
    end
    #sleep(0.2)

    chosen_move = good_moves.empty? ? random_move : good_moves.sample
    p chosen_move
    chosen_move
  end


end
