require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'

class Display
  # I really like the evenness, okay?
  CURSOR      = { background: :green,  color: :black, mode: :blink }.freeze
  SELECTED    = { background: :yellow, color: :black, mode: :blink }.freeze
  WHITE_SPACE = { background: :white                               }.freeze
  BLACK_SPACE = { background: :light_white                         }.freeze
  WHITE_PIECE = {                      color: :red                 }.freeze
  BLACK_PIECE = {                      color: :blue                }.freeze
  DEFAULT     = { background: :black,  color: :green               }.freeze

  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
    @board = board
    nil
  end

  def render
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        print_piece(piece, [i, j])
      end
      print "\n"
    end
    nil
  end

  def print_piece(piece, pos)
    print piece.to_s.colorize(set_color(piece, pos))
  end

  def set_color(piece, pos)
    cursor = @cursor.selected ? SELECTED : CURSOR
    return cursor if @cursor.cursor_pos == pos

    x, y = pos
    bg_color = ((x + y).even? ? WHITE_SPACE : BLACK_SPACE)

    return DEFAULT.merge(bg_color) if piece.null?

    piece_color = piece.color == :white ? WHITE_PIECE : BLACK_PIECE
    piece_color.merge(bg_color)
  end

  def renderloop
    running = true
    system('clear')
    while running
      render
      begin
        @cursor.get_input
        system('clear')
      rescue SystemExit
        puts "Game quit"
        running = false
      end
    end

    puts "Done!"
  end
end
