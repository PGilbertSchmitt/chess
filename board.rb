require_relative 'exceptions.rb'
require_relative 'pieces/null_piece.rb'
require_relative 'pieces/knight.rb'
require_relative 'pieces/king.rb'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
    populate
  end

  def populate
    row = Array.new(8) { Piece.new }
    @grid[0] = row.dup
    @grid[1] = row.dup
    @grid[6] = row.dup
    @grid[7] = row.dup
    @grid[0][1] = Knight.new(self, [0,1], :black)
    @grid[0][6] = Knight.new(self, [0,6], :black)
    @grid[7][1] = Knight.new(self, [7,1], :white)
    @grid[7][6] = Knight.new(self, [7,6], :white)

  end

  def move_piece(start_pos, end_pos)
    unless self.class.in_board_range?(start_pos) &&
      self.class.in_board_range?(end_pos)
        raise RangeError.new("Position is out of range!")
    end

    raise MissingPieceError.new if self[start_pos].null?

    piece = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos] = piece
  end

  def self.in_board_range?(pos)
    x, y = pos
    x.between?(0, 7) && y.between?(0, 7)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  private

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end
end
