
class Piece
    attr_reader :color, :board
    attr_accessor :position

    def initialize(color, board, position)
        @color = color
        @board = board
        @position = position
    end

    def to_s
        
    end

    def empty?
        return false
    end

    def valid_moves

    end

    def symbol

    end

    def pos=(val)
        
    end

    def move_into_check?(end_pos)

    end

end




