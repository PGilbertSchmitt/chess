require_relative '../board.rb'

class Piece
  attr_reader :color

  def initialize(board = nil, pos = nil, color = nil)
    @null = false
    @board = board
    @pos = pos
    @color = color
    @symbol = 'O'
  end

  def null?
    @null
  end

  def to_s
    @symbol
  end
end
