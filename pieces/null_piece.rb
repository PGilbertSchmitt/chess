require_relative 'piece.rb'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
    super(nil, nil, nil)
    @null = true
    @symbol = ' '
  end
end
