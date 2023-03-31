require_relative 'helper'
class Game
  include Helper
  attr_reader :board

  def initialize(player_one, player_two)
    @greeting = "\e[32mTic\e[0m \e[33mTac\e[0m \e[31mToe\e[0m"
    @empty = ' ' * 3
    @floor = '---+---+---'
    @wall = '|'
    @board = rest_board
    @players = { player_two: player_one, player_two: player_two }
  end

  def start_game
    build_board
    # while !check_win
    # end
  end

  def rest_board
    Array.new(3) { Array.new(3, @empty) }
  end

  def build_board
    @board.each_with_index do |row, i|
      construct_row(row)
      # No floor after the 3nd row
      typewriter(@floor, 0.01) if i < @board.length - 1
    end
  end

  def construct_row(row)
    full_row = ''
    row.each_with_index do |item, i|
      full_row += item + @wall if i < row.length - 1
      # No wall after 3rd item
      full_row += item unless i < row.length - 1
    end
    typewriter(full_row, 0.01)
  end

  def check_win
    # Check rows for a win
    @board.each do |row|
      return true if row.all? { |cell| cell == row[0] && !cell.strip.empty? }
    end

    # Check columns for a win
    3.times do |i|
      return true if @board[0][i] == @board[1][i] && @board[1][i] == @board[2][i] && !@board[0][i].strip.empty?
    end

    # Check diagonals for a win
    if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && !@board[0][0].strip.empty?
      return true
    elsif @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && !@board[0][2].strip.empty?
      return true
    end

    # No win found
    false
  end
end
