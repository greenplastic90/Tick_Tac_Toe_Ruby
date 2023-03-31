require_relative 'helper'

class Player
  include Helper
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = valid_name?(name) ? name : get_valid_name
    @symbol = valid_symbol?(symbol) ? "\e[31m #{symbol} \e[0m" : get_valid_symbol
  end

  def valid_name?(name)
    name.length <= 10 && !name.strip.empty? && !name.match?(/\s/)
  end

  def get_valid_name
    puts 'Error: name should be a single word and not longer than 10 characters.'
    new_name = gets.chomp
    until valid_name?(new_name)
      puts 'Error: name should be a single word and not longer than 10 characters.'
      new_name = gets.chomp
    end
    new_name
  end

  def valid_symbol?(symbol)
    symbol.length == 1 && symbol.match?(/[a-zA-Z]/)
  end

  def get_valid_symbol
    puts 'Error: symbol should be a single character from the alphabet.'
    new_symbol = gets.chomp
    until valid_symbol?(new_symbol)
      puts 'Error: symbol should be a single character from the alphabet.'
      new_symbol = gets.chomp
    end
    "\e[31m #{new_symbol} \e[0m"
  end

  def choice(game_board, empty)
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
    { cell: chosen_cell, symbol: @symbol }
  end
end
