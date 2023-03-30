x_red = "\e[31m X \e[0m"
o_red = "\e[31m O \e[0m"
empty = '   '

def build_board(game_board)
  floor = '---+---+---'
  wall = '|'
  game_board.each_with_index do |row, i|
    construct_row(row, wall)
    puts floor if i < game_board.length - 1
  end
end

def construct_row(row, wall)
  full_row = ''
  row.each_with_index do |item, i|
    full_row += item + wall if i < row.length - 1
    full_row += item unless i < row.length - 1
  end
  puts full_row
end

game_board = [[empty, empty, empty], [empty, empty, empty], [empty, empty, empty]]

build_board(game_board)
