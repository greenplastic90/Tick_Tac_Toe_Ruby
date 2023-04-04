require_relative 'helper'

class Player
  include Helper
  attr_reader :name, :symbol, :color
  attr_accessor :score

  def initialize(name, color, symbol)
    @name = valid_name?(name) ? name : get_valid_name(name)
    @color = color
    @symbol = valid_symbol?(symbol) ? colorize(" #{symbol} ", @color) : get_valid_symbol
    @score = 0
  end

  def valid_name?(name)
    !name.strip.empty? && !name.match?(/\s/)
  end

  def get_valid_name(name)
    try_again = 'Re-enter player name:'
    invalid_name_prompt = "#{colorize('Invalid name',
                                      :red)}: #{name}, name should be a single word."
    puts invalid_name_prompt
    print try_again
    new_name = gets.chomp
    until valid_name?(new_name)
      puts invalid_name_prompt
      print try_again
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
    colorize(" #{new_symbol} ", @color)
  end

  def choice(game_board, empty)
    symbol_no_spaces = @symbol.gsub(/\s(?=[a-zA-Z])/, '').gsub(/(?<=[a-zA-Z])\s/, '')
    puts "#{colorize(symbol_no_spaces, @color)} #{@name}'s turn:"
    empty_line
    available_cells = []
    # Create Array of available cells
    game_board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next unless cell == empty

        available_cells << [i, j]
      end
    end

    available_cells.each_with_index do |coords, index|
      cell_name = case coords
                  when [0, 0]
                    'Top Left'
                  when [0, 1]
                    'Top Middle'
                  when [0, 2]
                    'Top Right'
                  when [1, 0]
                    'Middle Left'
                  when [1, 1]
                    'Center'
                  when [1, 2]
                    'Middle Right'
                  when [2, 0]
                    'Bottom Left'
                  when [2, 1]
                    'Bottom Middle'
                  when [2, 2]
                    'Bottom Right'
                  end
      list_number = index + 1
      puts "#{colorize(list_number.to_s, @color)}. #{cell_name}"
      sleep 0.1
    end

    chosen_cell = nil
    until chosen_cell
      empty_line
      print "Choose an available cell (#{colorize('number', @color)}): "

      input = gets.chomp.to_i
      if input.between?(1, available_cells.length)
        chosen_cell = available_cells[input - 1]
      else
        puts 'Invalid choice. Please try again.'
      end
    end

    { cell: chosen_cell, symbol: @symbol }
  end
end
