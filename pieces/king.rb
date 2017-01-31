require_relative 'piece.rb'
require_relative 'modules/stepable.rb'

class King < Piece
  include Stepable

  def initialize(board, pos, color)
    super
    @symbol = 'K'
  end
end
