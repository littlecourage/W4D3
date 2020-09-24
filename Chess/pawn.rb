require_relative 'pieces'

class Pawn < Piece
    attr_reader :symbol
    def initialize(color, board, position)
        @symbol = :P
        super(color, board, position)
    end

    def symbol
        '♟︎'.colorize(color)
    end

    def moves
        array = []
        self.forward_dir.each do |position|
            if self.board.valid_pos?(position) && self.board[position].empty?
                array << position
            else
                break
            end
        end
        self.side_attacks.each do |position|
            if self.board.valid_pos?(position) && !self.board[position].empty? && self.color != self.board[position].color
                array << position
            else
                break
            end
        end
        array
    end

    def at_start_row?
        if (self.color == :white && self.position[0] == 6) || (self.color == :black && self.position[0] == 1)
            true
        else
            false
        end
    end

    def forward_dir
        if self.at_start_row? && self.color == :white
            return [[self.position[0] - 1, self.position[1]], [self.position[0] - 2, self.position[1]]]
        elsif self.at_start_row? && self.color == :black
            return [[self.position[0] + 1, self.position[1]], [self.position[0] + 2, self.position[1]]]
        elsif self.color == :white
            return [self.position[0] - 1, self.position[1]]
        elsif self.color == :black
            return [self.position[0] + 1, self.position[1]]
        end
    end

    def side_attacks
        if self.color == :white
            return [[self.position[0] - 1, self.position[1] - 1], [self.position[0] - 1, self.position[1] + 1]]
        elsif self.color == :black
            return [[self.position[0] + 1, self.position[1] - 1], [self.position[0] + 1, self.position[1] + 1]]
        end
    end
end

