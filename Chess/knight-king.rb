require_relative 'pieces'

module Stepable
    def moves
        diffs = self.move_diffs
        legal_moves = []
        current_pos = self.position
        diffs.each do |diff|
            check_pos = [current_pos[0] + diff[0], current_pos[1] + diff[1]]
            if self.board.valid_pos?(check_pos)
                if self.board[check_pos].empty?
                    legal_moves << check_pos
                elsif self.color != self.board[check_pos].color
                    legal_moves << check_pos
                end
            end
        end
        legal_moves
    end

    # private

    def move_diffs
        raise NotImplementedError
    end
end

class Knight < Piece
    include Stepable
    def initialize(color, board, position)
        super(color, board, position)
    end

    def symbol
        '♞'.colorize(color)
    end
    
    def move_diffs
        moves = [[1,2],[2,1],[1,-2],[2,-1],[-1,2],[-2,1],[-1,-2],[-2,-1]]
    end
end

class King < Piece
    include Stepable
    def initialize(color, board, position)
        super(color, board, position)
    end

    def symbol
        '♚'.colorize(color)
    end

    def move_diffs
        moves = [[0,1],[0,-1],[1,0],[-1,0],[1,1],[1,-1],[-1,1],[-1,-1]]
    end
end