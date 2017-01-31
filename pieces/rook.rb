require_relative 'piece.rb'
require_relative 'modules/slideable.rb'

class Rook < Piece
  include Slideable

  def initialize(board, pos, color)
    super
    @symbol = 'R'
  end
end
