require_relative 'piece.rb'
require_relative 'modules/stepable.rb'

class Knight < Piece
  include Stepable

  def initialize(board, pos, color)
    super
    @symbol = 'N'
  end
end
