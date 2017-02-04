require_relative 'piece.rb'
require_relative 'modules/slideable.rb'

class Bishop < Piece
  include Slideable

  def initialize(board, pos, color)
    super
    @symbol = "\u265D "
  end
end
