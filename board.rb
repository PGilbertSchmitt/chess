require_relative 'exceptions.rb'
Dir["pieces/*.rb"].each { |file| require_relative file }

class Board

  attr_accessor :grid

  def self.in_board_range?(pos)
    x, y = pos
    x.between?(0, 7) && y.between?(0, 7)
  end

  def self.enemy_color(color)
    color == :black ? :white : :black
  end

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
    populate
  end

  def populate
    @grid[0][0] = Rook.new(self, [0,0], :black)
    @grid[0][1] = Knight.new(self, [0,1], :black)
    @grid[0][2] = Bishop.new(self, [0,2], :black)
    @grid[0][3] = Queen.new(self, [0,3], :black)
    @grid[0][4] = King.new(self, [0,4], :black)
    @grid[0][5] = Bishop.new(self, [0,5], :black)
    @grid[0][6] = Knight.new(self, [0,6], :black)
    @grid[0][7] = Rook.new(self, [0,7], :black)
    black_pawns = Array.new(8)
    black_pawns.each_index do |idx|
      black_pawns[idx] = Pawn.new(self, [1, idx], :black)
    end
    @grid[1] = black_pawns

    @grid[7][0] = Rook.new(self, [7,0], :white)
    @grid[7][1] = Knight.new(self, [7,1], :white)
    @grid[7][2] = Bishop.new(self, [7,2], :white)
    @grid[7][3] = Queen.new(self, [7,3], :white)
    @grid[7][4] = King.new(self, [7,4], :white)
    @grid[7][5] = Bishop.new(self, [7,5], :white)
    @grid[7][6] = Knight.new(self, [7,6], :white)
    @grid[7][7] = Rook.new(self, [7,7], :white)
    white_pawns = Array.new(8)
    white_pawns.each_index do |idx|
      white_pawns[idx] = Pawn.new(self, [6, idx], :white)
    end
    @grid[6] = white_pawns

    @grid[1][3] = Bishop.new(self, [1,3], :white)
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

  def piece_color(pos)
    self[pos].color
  end

  def find_king(color)
    @grid.flatten.each do |piece|
      return piece.pos if piece.color == color && piece.is_a?(King)
    end
    raise "No King!"
  end

  def in_check?(color)
    king_position = find_king(color)

    enemy_color = self.class.enemy_color(color)
    enemies = []
    @grid.flatten.each do |piece|
      enemies << piece if piece.color == enemy_color
    end

    enemies.each do |enemy|
      return true if enemy.moves.include?(king_position)
    end

    false
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def dup
    new_board = Board.new
    new_board.grid = self.grid.dup
    new_board.grid.each_with_index do |row, i|
      new_board.grid[i] = row.dup
      row.each_with_index do |piece, j|
        new_board[[i,j]] = piece.dup(new_board)
      end
    end

    new_board
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end
end
