WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,board.length - 1) && !position_taken?(board, index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    puts "invalid"
    turn(board)
  end
end

def turn_count(board)
  size = board.select {|i| i == " "}
  board.length - size.length
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |i|
    board[i[0]] == board[i[1]] &&
    board[i[1]] == board[i[2]] &&
    position_taken?(board, i[0])
  end
end

def full?(board)
  board.none? {|i| i == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if winner = won?(board)
    board[winner.first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

board0 = [" ", " ", " ", " ", " ", " ", " ", " ", " "] #=> empty, false
board1 = ["X", "O", "X", "X", "O", "X", "O", "X", "O"] #=> draw, true
board2 = ["X", "X", "X", "O", "O", "X", "X", "O", "O"] #=> Win X, first row, true
board3 = ["X", "O", "O", "O", "X", "O", "O", "X", "X"] #=> Win X, left diag, true
board4 = ["X", "X", "O", "O", "O", "X", "O", "X", "X"] #=> Win O, right diag, true
board5 = ["X", "O", "X", "X", "O", "O", "O", "O", "X"] #=> Win O, mid col, true
board6 = ["O", "O", "O", " ", "X", "X", " ", " ", "X"] #=> Win O, first row, true
board7 = [" ", "X", "O", "O", "X", " ", " ", "X", "O"] #=> Win X, mid col, true

boards = [board0, board1, board2, board3, board4, board5, board6, board7]

#boards.each do |brd|
#  puts "----------------------------------------------------------------------"
#  puts "----------------------------------------------------------------------"
#  print "#{won?(brd)}\n"
#end
