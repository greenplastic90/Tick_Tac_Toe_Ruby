require_relative 'helper'
class Game
  include Helper
  def initialize
    @greeting = "\e[32mTic\e[0m \e[33mTac\e[0m \e[31mToe\e[0m"
    @empty = ' ' * 3
    @floor = '---+---+---'
    @wall = '|'
    @game_board = rest_board
  end

  def start_game
    build_board
  end

  def rest_board
    Array.new(3) { Array.new(3, @empty) }
  end

  def build_board
    @game_board.each_with_index do |row, i|
      construct_row(row)
      # No floor after the 3nd row
      typewriter(@floor, 0.01) if i < @game_board.length - 1
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
    @game_board.each do |row|
      return true if row.all? { |cell| cell == row[0] && !cell.strip.empty? }
    end

    # Check columns for a win
    3.times do |i|
      if @game_board[0][i] == @game_board[1][i] && @game_board[1][i] == @game_board[2][i] && !@game_board[0][i].strip.empty?
        return true
      end
    end

    # Check diagonals for a win
    if @game_board[0][0] == @game_board[1][1] && @game_board[1][1] == @game_board[2][2] && !@game_board[0][0].strip.empty?
      return true
    elsif @game_board[0][2] == @game_board[1][1] && @game_board[1][1] == @game_board[2][0] && !@game_board[0][2].strip.empty?
      return true
    end

    # No win found
    false
  end

  def player_turn(game_board, empty, symbol)
    puts "\e[31mX\e[0m player's turn:"
    available_cells = []
    game_board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next unless cell === empty

        cell_name = case [i, j]
                    when [0, 0]
                      '1. Top Left'
                    when [0, 1]
                      '2. Top Middle'
                    when [0, 2]
                      '3. Top Right'
                    when [1, 0]
                      '4. Middle Left'
                    when [1, 1]
                      '5. Center'
                    when [1, 2]
                      '6. Middle Right'
                    when [2, 0]
                      '7. Bottom Left'
                    when [2, 1]
                      '8. Bottom Middle'
                    when [2, 2]
                      '9. Bottom Right'
                    end
        puts cell_name
        available_cells << [i, j]
      end
    end

    chosen_cell = nil
    until chosen_cell
      print 'Choose an available cell (number): '
      input = gets.chomp.to_i
      if input.between?(1, available_cells.length)
        chosen_cell = available_cells[input - 1]
      else
        puts 'Invalid choice. Please try again.'
      end
    end
    system('clear')
    game_board[chosen_cell[0]][chosen_cell[1]] = symbol
  end
end
