require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        @board.rows.each do |row|
            puts row.map {|piece| piece.symbol}.join(" ")
        end
        return
    end

    def play
        i = 0
        while i < 10
            self.render
            @cursor.get_input
            i += 1
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    b = Board.new
    d = Display.new(b)
    d.play
end