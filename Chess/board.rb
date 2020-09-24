require 'byebug'
require_relative 'pieces'
require_relative 'nullpiece'
require_relative 'rook-bishop-queen'
require_relative 'knight-king'
require_relative 'pawn'

# [[R][KN][B][Q][K][B][KN][R]]
# [P] [P][P] [P][P] [P][P] [P]
# [ ] [ ][KN] [ ][ ] [ ][ ] [ ]
# [ ] [ ][ ] [ ][ ] [ ][ ] [ ]
# [ ] [ ][ ] [ ][ ] [ ][ ] [ ]
# [ ] [ ][ ] [ ][ ] [ ][ ] [ ]
# [P][P] [P] [P][P] [P] [P][P]
# [R][KN][B][K][Q][B][KN][R]


class Board
    attr_reader :rows

    def initialize
        @sentinel = NullPiece.instance
        self.make_starting_grid(@sentinel)
        # self.pieces
        
    end

    def [](pos)
        x,y = pos
        @rows[x][y]
    end

    def []=(pos, val)
        x,y = pos
        @rows[x][y] = val
    end

    def move_piece(start_pos, end_pos)
        if self.valid_pos?(start_pos) && self.valid_pos?(end_pos) && self[start_pos].moves.include?(end_pos)
            piece = self[start_pos]
            self[start_pos] = @sentinel
            self[end_pos] = piece
            piece.position = end_pos
        end
    end

    def valid_pos?(pos)
        x, y = pos
        unless x.between?(0, 7) && y.between?(0, 7)
            return false
        end
        true
    end

    # def pieces
    #     (0...@rows.length).each do |row|
    #         (0...@rows.length).each do |col|
    #             if [0, 1, 6, 7].include?(row)
    #                 self[[row, col]] = Piece.new
    #             else
    #                 self[[row, col]] = nil
    #             end
    #         end
    #     end
    # end

    def make_starting_grid(sentinel)
        @rows = Array.new(8) { Array.new(8, sentinel) }
        #return unless fill_board
        #creating an array= [:white, :black]
        [:white, :black].each do |color|
            fill_back_row(color)
            fill_pawn_row(color)
        end
    end

    def fill_back_row(color)
        back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        if color == :white
            i = 7
        elsif color == :black #black pieces
            i = 0
        end

        back_pieces.each_with_index do |piece_class, j|
            self[[i,j]] = piece_class.new(color, self, [i, j])
        end
    end

    def fill_pawn_row(color)
        if color == :white
            i = 6
        elsif color == :black #black pieces
            i = 1
        end
        8.times do |j|
            self[[i,j]] = Pawn.new(color, self, [i, j])
        end
    end

end

# horizontal dirs and diagonal_dirs are getter methods for class variables
# move dirs invoked inside of moves
# iterate over each direction in moves method, call grow_unblocked_moves for each direction in moves
# moves should output all possible moves for a given piece


    # def self.valid_moves(pos)
    #     moves = [ [-2, -1],[-2,  1],[-1, -2],[-1,  2],[ 1, -2],[ 1,  2],[ 2, -1],[ 2,  1] ]
    #     possible_moves = []
    #     moves.each do |ele|
    #         x, y = pos
    #         possible_moves << [ele[0] + x, ele[1]+y]
    #     end
    #     possible_moves.delete_if { |ele| ele[0] > 7 || ele[1] > 7 || ele[0] < 0 || ele[1] < 0 }
    #     return possible_moves
    # end