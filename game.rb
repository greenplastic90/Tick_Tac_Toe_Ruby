require_relative 'helper'

class Game
  include Helper
  attr_reader :board

  def initialize(player_one, player_two)
    @greeting = "#{colorize('Tic', :green)} #{colorize('Tac', :yellow)} #{colorize('Toe', :red)}"
    @empty = ' ' * 3
    @floor = colorize('---+---+---', :magenta)
    @wall = colorize('|', :magenta)
    @board = rest_board
    @players = { player_one: player_one, player_two: player_two }
  end

  def start_game
    system('clear')
    typewriter(@greeting, 0.1)
    build_board

    is_player_one_turn = true
    game_result = check_win_or_tie?
    until %i[win tie].include?(game_result)
      player = is_player_one_turn ? @players[:player_one] : @players[:player_two]
      choice = player.choice(@board, @empty)
      update_board(choice)
      system('clear')
      build_board

      is_player_one_turn = !is_player_one_turn
      game_result = check_win_or_tie?
    end

    case game_result
    when :win
      winner = is_player_one_turn ? 'Player Two' : 'Player One'
      puts "#{winner} wins!"
    when :tie
      puts "It's a tie!"
    end
  end

  def rest_board
    Array.new(3) { Array.new(3, @empty) }
  end

  def update_board(choice)
    @board[choice[:cell][0]][choice[:cell][1]] = choice[:symbol]
  end

  def build_board
    system('clear')
    puts @greeting
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

  def check_win_or_tie?
    # Check rows for a win
    @board.each do |row|
      return :win if row.all? { |cell| cell == row[0] && !cell.strip.empty? }
    end

    # Check columns for a win
    3.times do |i|
      return :win if @board[0][i] == @board[1][i] && @board[1][i] == @board[2][i] && !@board[0][i].strip.empty?
    end

    # Check diagonals for a win
    if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && !@board[0][0].strip.empty?
      return :win
    elsif @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && !@board[0][2].strip.empty?
      return :win
    end

    # Check for a tie
    return :tie if @board.all? { |row| row.all? { |cell| !cell.strip.empty? } }

    # No win or tie found
    :none
  end
end
