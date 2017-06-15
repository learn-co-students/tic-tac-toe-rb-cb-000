$x = " "
#helper methods
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  #horizontal
  [0,1,2],
  [3,4,5],
  [6,7,8],
  #vertical
  [0,3,6],
  [1,4,7],
  [2,5,8],
  #diagonal
  [0,4,8],
  [6,4,2]
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input_to_index method. Converts input to index
def input_to_index(input)
  input = input.to_i
  index = input - 1
  return index
end

#move method
def move(board, index, value)
  board[index] = value
  return board
end

##position_taken? method
def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] != " " || board[index] != ""
    return true
  end
end

#valid_move? method
def valid_move?(board, index)
  position_taken?(board, index) == false && index.between?(0,8) ? true : false
end

#turn_count method
def turn_count(board)
  counter = 0
  board.each do |element|
    if element == "X" || element == "O"
      counter += 1
    end
  end
  return counter
end

#current_player method
def current_player(board)
  turn_counter = turn_count(board)
  if turn_counter % 2 == 0
    return "X"
  elsif turn_counter == 0
    return "X"
  else
    return "O"
  end
end

#turn method
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip.to_i
  index = input_to_index(input)
  value = current_player(board)
  if valid_move?(board, index)
      move(board, index, value)
  else
    turn(board)
  end
  display_board(board)
end

def full?(board)
  board.all? do |index|
    index.include?("X") || index.include?("O")
  end
end

#won? method. Cheks if the game has been won
def won?(board)
  x_win = false
  o_win = false
  x_win_array = 0
  o_win_array = 0
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]


    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      x_win = true
    #  x_win_array = win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      o_win = true
    #  o_win_array = win_combination
    elsif position_1 == " " && position_2 == " " && position_3 == " "
      empty = true
    end
  end
if x_win == false && o_win == false
  $x = nil
  return false
elsif x_win == true
  $x = "X"
  return true
elsif o_win == true
  $x = "O"
  return true
else empty == true
  return false

end
end

#draw method. Checks if the game has been a draw
def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
=begin  elsif won?(board) == false && full?(board) == false
    return false
  elsif won?(board) == true
   return false
=end
  end
end

# over? method. Checks if the game has been over
def over?(board)
  if won?(board) == true || draw?(board) == true || full?(board) == true
    return true
  else false
  end
end

# winner method. Returns the player who won.
def winner(board)
  won?(board)
  if $x == "X"
    return $x
  elsif $x == "O"
    return $x
  elsif $x == nil
    return nil
  end
end

#play method. Constitutes the main game loop
def play(board)
while over?(board) == false
  turn(board)
end
if won?(board)
  puts "Congratulations #{$x}!"
else
  puts "Cats Game!"
end
end
