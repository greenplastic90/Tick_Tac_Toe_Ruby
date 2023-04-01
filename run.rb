require_relative 'game'
require_relative 'player'

player_one = Player.new('PlayerOne', :yellow, 'X')
player_two = Player.new('PlayerTwo', :cyan, 'O')
game = Game.new(player_one, player_two)

game.start_game

# ! Score board
