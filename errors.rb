class MoveError < IOError
end

class InvalidMoveError < MoveError
  def message
    "Not one of the possible moves for that piece."
  end
end

class NoPieceError < MoveError
  def message
    "You didn't select a piece."
  end
end

class WrongColorError < MoveError
  def message
    "You are attempting to move your opponent's piece"
  end
end

class BadInputError < MoveError
  def message
    "Excuse me? Please provide valid input."
  end
end

class OffBoardError < MoveError
  def message
    "That position is off the board."
  end
end
