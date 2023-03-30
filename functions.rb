def rest_board
  empty = '   '
  Array.new(3) { Array.new(3, empty) }
end

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

def check_win(game_board)
  # Check rows for a win
  game_board.each do |row|
    return true if row.all? { |cell| cell == row[0] && !cell.strip.empty? }
  end

  # Check columns for a win
  3.times do |i|
    if game_board[0][i] == game_board[1][i] && game_board[1][i] == game_board[2][i] && !game_board[0][i].strip.empty?
      return true
    end
  end

  # Check diagonals for a win
  if game_board[0][0] == game_board[1][1] && game_board[1][1] == game_board[2][2] && !game_board[0][0].strip.empty?
    return true
  elsif game_board[0][2] == game_board[1][1] && game_board[1][1] == game_board[2][0] && !game_board[0][2].strip.empty?
    return true
  end

  # No win found
  false
end
