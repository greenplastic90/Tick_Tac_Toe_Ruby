require_relative 'functions'

x_red = "\e[31m X \e[0m"
o_red = "\e[31m O \e[0m"
greeting = "\e[32mTic\e[0m \e[33mTac\e[0m \e[31mToe\e[0m"

game_board = rest_board
typewriter(greeting, 0.1)
build_board(game_board)
