# Tic Tac Toe Winning combinations constant
WIN_COMBINATIONS = [
  [0,1,2], #top row win
  [3,4,5], #middle row win
  [6,7,8], #bottom row win
  [0,3,6], #first col win
  [1,4,7], #second col win
  [2,5,8], #third col win
  [0,4,8], #diagonal win
  [2,4,6] #diagonal win
]
# Display board method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# Convert user input to array index
def input_to_index(user_input)
  arr_index = user_input.to_i - 1
  return arr_index
end
# The move method fills in the board with the players input, either "X" or "O"
def move(board, position, char)
  board[position] = char
end
# Check if users selected position is already taken
def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    return true
  end
    false
end
# VALIDATE USER INPUT HELPER METHOD
def valid_move?(board, position)
 if position.between?(0,9) && board[position] == " "
   return true
 end
end
# ASK USER TO PLAY -> VALIDATE USER INPUT -> DISPLAY BOARD
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  arr_index = input_to_index(user_input)
  position = current_player(board)

  if !valid_move?(board, arr_index)
    puts "Please enter a different option"
    user_input = gets.strip
  else
      move(board, arr_index, position)
      display_board(board)
  end

end
# DETERMINE HOW MANY TURNS HAVE PASSED
def turn_count(board)
  counter = 0
  board.each do |element|
    if element == "O" || element == "X"
      counter += 1
    end
  end
  return counter
end
# DETERMINE CURRENT PLAYER
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
# CHECK IF THERE IS ANY WINNER
def won?(board)
  WIN_COMBINATIONS.each do |win|
   if [board[win[0]], board[win[1]], board[win[2]]] == ["X", "X", "X"] ||
      [board[win[0]], board[win[1]], board[win[2]]] == ["O", "O", "O"]
     return win
   end
  end
   return false
end
# CHECK IF THE GAME IS FULL WITHOUT A WINNER
def full?(board)
  if won?(board) == false && board.all? {|element| element != " "}
    return true
  else
    false
  end
end
#CHECK IF THE GAME IS DRAW
def draw?(board)
  won_check = won?(board)
  fullboard_check = full?(board)
  if won_check == false && fullboard_check == true
    return true
  elsif won_check == false && fullboard_check == false
    return false
  elsif won_check != false
    return false
  end
end
# CHECK IF GAME IS OVER // WON OR DRAW
def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end
# CHECK WHOS THE WINNER
def winner(board)
  WIN_COMBINATIONS.each do |win|
   if [board[win[0]], board[win[1]], board[win[2]]] == ["X", "X", "X"]
     return "X"
   elsif [board[win[0]], board[win[1]], board[win[2]]] == ["O", "O", "O"]
     return "O"
   end
  end
    return nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
