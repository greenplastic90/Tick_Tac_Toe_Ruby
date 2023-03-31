require_relative 'game'

x_red = "\e[31m X \e[0m"
o_red = "\e[31m O \e[0m"
empty = '   '

game = Game.new

game.start_game

# game_board = rest_board(empty)
# # ! typewriter(greeting, 0.1)
# build_board(game_board)

# player_turn(game_board, empty, x_red)

# build_board(game_board)

# ! Create a class for player, that has symbol and player name to pass into the player_turn method.
# ! Score board
