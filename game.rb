require_relative 'helper'

class Game
  include Helper
  attr_reader :board

  def initialize(player_one, player_two, title: '')
    @title = title.empty? ? "#{colorize('Tic', :yellow)} #{colorize('Tac', :magenta)} #{colorize('Toe', :cyan)}" : title
    @empty = ' ' * 3
    @floor = colorize('---+---+---', :magenta)
    @wall = colorize('|', :magenta)
    @board = rest_board
    @players = { player_one: player_one, player_two: player_two }
  end

  def self.title(title = '')
    new(nil, nil, title: title).instance_variable_get(:@title)
  end

  def start_game
    system('clear')
    typewriter(@title, 0.01)

    build_board

    is_player_one_turn = true

    until %i[win tie].include?(game_status)
      player = is_player_one_turn ? @players[:player_one] : @players[:player_two]
      choice = player.choice(@board, @empty)
      update_board(choice)
      system('clear')
      build_board
      is_player_one_turn = !is_player_one_turn
    end

    is_player_one_turn = !is_player_one_turn
    winner = is_player_one_turn ? @players[:player_one] : @players[:player_two]
    case game_status
    when :win
      winner.score += 1
    end

    build_board(false)

    case game_status
    when :win
      puts "#{colorize(winner.name, winner.color)} wins!"
    when :tie
      puts "It's a tie!"
    end

    empty_line

    # Ask the players if they want to play again
    restart_prompt = "Do you want to play again? (#{colorize('1', :bright_green)}. Yes, #{colorize('2', :red)}. No): "
    print restart_prompt
    choice = gets.chomp.to_i
    until [1, 2].include?(choice)
      puts "Invalid choice. Please enter #{colorize('1', :bright_green)} for Yes or #{colorize('2', :red)} for No."
      print restart_prompt
      choice = gets.chomp.to_i
    end

    if choice == 1
      # Reset the game and start over
      @board = rest_board
      start_game
    else
      # End the game
      puts 'Thanks for playing!'
    end
  end

  def score_board
    space = @players[:player_one].name.length
    puts "#{@players[:player_one].name} #{@players[:player_two].name}"
    puts "#{colorize(@players[:player_one].score,
                     @players[:player_one].color)}#{' ' * space}#{colorize(@players[:player_two].score,
                                                                           @players[:player_two].color)}"
    empty_line
  end

  def rest_board
    Array.new(3) { Array.new(3, @empty) }
  end

  def update_board(choice)
    @board[choice[:cell][0]][choice[:cell][1]] = choice[:symbol]
  end

  def build_board(use_typewriter = true)
    system('clear')
    puts @title
    empty_line
    score_board
    @board.each_with_index do |row, i|
      construct_row(row, use_typewriter)
      # No floor after the 3nd row
      if use_typewriter
        typewriter(@floor, 0.01) if i < @board.length - 1
      elsif i < @board.length - 1
        puts @floor
      end
    end
    empty_line
  end

  def construct_row(row, use_typewriter)
    full_row = ''
    row.each_with_index do |item, i|
      full_row += item + @wall if i < row.length - 1
      # No wall after 3rd item
      full_row += item unless i < row.length - 1
    end
    if use_typewriter
      typewriter(full_row, 0.01)
    else
      puts full_row
    end
  end

  def game_status
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
