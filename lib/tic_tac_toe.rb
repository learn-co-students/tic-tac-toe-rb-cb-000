WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [6, 4, 2],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  turn(board)
  if won?(board)
    puts "Congratulations #{winner(board)}"
  elsif draw?(board)
    puts "Cat's game!"
  else
    turn(board)
  end
end

def turn(board)
  puts "Please enter 1-9:"
  inp = gets.strip
  index = input_to_index(inp)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def input_to_index(inp)
  i = inp.to_i
  (i >= 0 && i <= 8) ? i - 1 : -1
end

def move(board, index, player_token)
  #if !position_taken?(board, index)
  board[index] = player_token
  #end
end

def valid_move?(board, index)
  !position_taken?(board, index)
end

def position_taken?(board, index)
  (board[index] == "X" || board[index] == "O")
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|cell| cell == "X" || cell == "O"}
end
