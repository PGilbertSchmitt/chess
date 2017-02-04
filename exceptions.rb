class MissingPieceError < StandardError
  def initialize(msg = 'No piece here')
    super
  end
end

class CantReachError < StandardError
  def initialize(msg = "Can't reach this position")
    super
  end
end
