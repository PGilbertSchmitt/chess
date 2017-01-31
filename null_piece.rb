require_relative 'piece.rb'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
    super
    @null = true
  end

  def to_s
    ' '
  end
end
