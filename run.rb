require_relative 'game'
require_relative 'player'

system('clear')
# puts 'Welcome to Tic Tac Toe!'
puts Game.title
puts ''
print 'Player One, enter your name: '
player_one_name = gets.chomp
print 'Player Two, enter your name: '
player_two_name = gets.chomp

player_one = Player.new(player_one_name, :yellow, 'X')
player_two = Player.new(player_two_name, :cyan, 'O')
game = Game.new(player_one, player_two)

game.start_game
