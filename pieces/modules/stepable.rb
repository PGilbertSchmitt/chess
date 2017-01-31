module Stepable
  def moves
    possible_spots = move_diffs.map { |mov|  add_pos(@pos, mov) }
    possible_spots.select! { |spot| Board.in_board_range?(spot) }
    possible_spots.reject! { |spot| @board[spot].color == @color }
    possible_spots
  end

  private

  def move_diffs
    return MOVE_TYPE[:king]   if self.is_a?(King)
    return MOVE_TYPE[:knight] if self.is_a?(Knight)
    raise "No such differential for piece: #{self.class}"
  end

  MOVE_TYPE = {
    king: [
      [-1,-1], [ 0,-1], [ 1,-1],
      [-1, 0],          [ 1, 0],
      [-1, 1], [ 0, 1], [ 1, 1]
    ],
    knight: [
      [-2,  1],
      [-2, -1],
      [-1,  2],
      [-1, -2],
      [ 1,  2],
      [ 1, -2],
      [ 2,  1],
      [ 2, -1]
    ]
  }

  def add_pos(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end
end
