class MoveError < IOError
end

class InvalidMoveError < MoveError
end

class NoPieceError < MoveError
end
