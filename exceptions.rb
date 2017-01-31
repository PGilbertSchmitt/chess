class MissingPieceError < StandardError
  def initialize(msg = 'No piece here')
    super
  end
end
