require_relative 'piece.rb'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
    super(nil, nil, nil)
    @null = true
    @symbol = ' '
  end

  def dup(board)
    self.class.instance
  end
end
