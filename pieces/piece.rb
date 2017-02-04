require_relative '../board.rb'

class Piece
  attr_reader :pos
  attr_accessor :board, :color

  def initialize(board = nil, pos = nil, color = nil)
    @null = false
    @board = board
    @pos = pos
    @color = color
    @symbol = 'O '
  end

  def null?
    @null
  end

  def to_s
    @symbol
  end

  def dup(board)
    new_piece = self.class.new(board, @pos, @color)
  end
end
