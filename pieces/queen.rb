require_relative 'piece.rb'
require_relative 'modules/slideable.rb'

class Queen < Piece
  include Slideable

  def initialize(board, pos, color)
    super
    @symbol = "\u265B"
  end
end
