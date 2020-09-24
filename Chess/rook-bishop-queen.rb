require 'byebug'
require_relative 'pieces'
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


module Slideable
    HORIZONTAL_DIRS = [[0,1], [0,-1], [1,0], [-1,0]]
    DIAGONAL_DIRS = [[1,1],[1,-1],[-1,1],[-1,-1]]

    def horizontal_dirs
        Slideable::HORIZONTAL_DIRS
    end

    def diagonal_dirs
        Slideable::DIAGONAL_DIRS
    end

    def moves
        dirs = self.move_dirs
        legal_moves = []
        dirs.each do |dir|
            legal_moves += self.grow_unblocked_moves_in_dir(dir[0], dir[1])
        end
        legal_moves
    end

    def move_dirs
        raise NotImplementedError
    end

    # def grow_unblocked_moves_in_dir(dx, dy)
    #     array = []
    #     current_position = self.position
    #     while self.board.valid_pos?(current_position)
    #         cur_row = current_position[0]
    #         cur_col = current_position[1]
    #         position = [dx + cur_row, dy + cur_col]
    #         if self.board.valid_pos?(position)
    #             if self.board[position].empty?
    #                 array << position
    #                 current_position = position
    #             elsif self.color != self.board[position].color
    #                 array << position
    #                 break
    #             end
    #         end
    #     end
    #     array
    # end

    def grow_unblocked_moves_in_dir(dx, dy)
        array = []
        i = 1
        # debugger
        current_position = [self.position[0] + (dx * i), self.position[1] + (dy * i)]
        while self.board.valid_pos?(current_position)
            current_position = [self.position[0] + (dx * i), self.position[1] + (dy * i)]
            if self.board[current_position].empty?
                array << current_position
                i += 1
            elsif self.color != self.board[current_position].color
                array << current_position
                break
            else
                break
            end
        end
        array
    end
end

class Rook < Piece
    include Slideable
    def initialize(color, board, position)
        super(color, board, position)
    end

    def symbol
        '♜'.colorize(color)
    end

    def move_dirs
        self.horizontal_dirs
    end
end

class Bishop < Piece
    include Slideable
    def initialize(color, board, position)
        super(color, board, position)
    end

    def symbol
        '♝'.colorize(color)
    end

    def move_dirs
        self.diagonal_dirs
    end
end

class Queen < Piece
    include Slideable
    def initialize(color, board, position)
        super(color, board, position)
    end

    def symbol
        '♛'.colorize(color)
    end

    def move_dirs
        self.horizontal_dirs + self.diagonal_dirs
    end
end