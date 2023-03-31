require_relative 'game'
require_relative 'player'

player_one = Player.new('Bashar', 'X')
player_two = Player.new('Rawan', 'O')
game = Game.new(player_one, player_two)

game.start_game

# ! Create a class for player, that has symbol and player name to pass into the player_turn method.
# ! Score board
