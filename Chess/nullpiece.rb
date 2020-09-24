require_relative 'pieces'
require 'singleton'

class NullPiece < Piece
    include Singleton

    attr_reader :color, :symbol

    def initialize
        @symbol = " "
        @color = :none
    end

    def moves
        return []
    end

    def empty?
        return true
    end
end