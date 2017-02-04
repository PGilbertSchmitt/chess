require_relative '../board.rb'

class Piece
  attr_accessor :board, :color, :pos

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

  def moves
    []
  end

  def can_see?(other)
    moves.include?(other.pos)
  end

  def dup(board)
    self.class.new(board, @pos, @color)
  end
end
