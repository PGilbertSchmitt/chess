module Slideable
  def moves

    possible_spots = []
    deltas = move_diffs

    deltas.each do |delta|
      possible_spots.concat(all_until(delta))
    end

    possible_spots
  end

  private

  def move_diffs
    return MOVE_TYPE[:bishop] if self.is_a?(Bishop)
    return MOVE_TYPE[:queen]  if self.is_a?(Queen)
    return MOVE_TYPE[:rook]   if self.is_a?(Rook)
    raise "No such differential for piece: #{self.class}"
  end

  MOVE_TYPE = {
    bishop: [
               [-1,-1],
      [ 1, -1],         [-1, 1],
               [ 1, 1]
    ],
    queen: [
      [-1,-1], [ 0,-1], [ 1,-1],
      [-1, 0],          [ 1, 0],
      [-1, 1], [ 0, 1], [ 1, 1]
    ],
    rook: [
      [0, -1], [-1, 0], [1, 0], [0, 1]
    ]
  }

  def add_pos(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end

  def all_until(delta)
    possible_spots = []

    1.upto(7) do |spaces|
      current_pos = add_pos(@pos, delta.map { |x| x * spaces } )
      return possible_spots unless Board.in_board_range?(current_pos)

      current_piece = @board[current_pos]
      if current_piece.color == nil
        possible_spots << current_pos
        next
      elsif current_piece.color == @color
        return possible_spots
      elsif current_piece.color != @color
        possible_spots << current_pos
        return possible_spots
      else
        raise "No such piece color: #{current_piece.color}"
      end
    end

    possible_spots
  end

end
