WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  return board
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def current_player(board)
  counter = turn_count(board)
  counter.even? ? "X" : "O"
end

def turn_count(board)
  board.count {|token| token == "X" || token == "O" }
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
  else move(board, index, current_player(board))
  display_board(board)
 end
end



def won?(board)
  WIN_COMBINATIONS.each do |combo|
  win_in_0 = combo[0]
  win_in_1 = combo[1]
  win_in_2 = combo[2]

  position_1 = board[win_in_0] # load the value of the board at win_index_1
  position_2 = board[win_in_1] # load the value of the board at win_index_2
  position_3 = board[win_in_2]

  if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
    return combo
   end
 end
  return false
 end

def full?(board)
   board.all? { |item| item != " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
 won?(board) || draw?(board)
end

def winner(board)
  if won?(board) && board[won?(board)[0]] == "O"
    "O"
  elsif won?(board) && board[won?(board)[0]] == "X"
    "X"
  end
end

def play(board)
  while !over?(board)
  turn(board)
  end
  if won?(board)
     puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
     puts "Cat's Game!"
  end
 end
