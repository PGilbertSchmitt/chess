require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'

class Display
  # DEFAULT = {}.freeze
  CURSOR = {:background => :green, :color => :black}.freeze
  SELECTED = {:background => :yellow, :color => :black }.freeze

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        print_piece(piece, [i,j])
      end
      print "\n"
    end
    nil
  end

  def print_piece(piece, pos)
    piece_char = piece.render
    if pos == @cursor.cursor_pos
      if @cursor.selected
        print piece_char.colorize(SELECTED) + ' '
      else
        print piece_char.colorize(CURSOR) + ' '
      end
    else
      print piece_char + ' '
    end
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