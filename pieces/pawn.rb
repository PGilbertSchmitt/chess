require_relative 'piece.rb'

class Pawn < Piece

  def initialize(board, pos, color)
    super
    @symbol = "\u265F"
  end

  def moves
    direction = @color == :black ? 1 : -1

    possible_spots = []
    forward = add_pos(@pos, [direction, 0])

    if Board.in_board_range?(forward) && @board[forward].null?
      possible_spots << forward
    end

    attacks = [[direction, 1], [direction, -1]]

    attacks.each do |attack|
      spot = add_pos(@pos, attack)
      unless Board.in_board_range?(spot)
        next
      end
      enemy_color = @color == :black ? :white : :black
      unless @board[spot].color == enemy_color
        next
      end
      possible_spots << spot
    end

    possible_spots
  end

  private

  def add_pos(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end

end
