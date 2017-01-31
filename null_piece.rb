require_relative 'piece.rb'

class NullPiece < Piece
  def initialize
    super
    @null = true
  end

  def render
    ' '
  end
end
