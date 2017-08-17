
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row

  [0,3,6], # Left col
  [1,4,7], # Middle col
  [2,5,8], # Right col

  [0,4,8], # Left top corner row
  [2,4,6], # Right top corner row
]

# Helper Methods

# Display Board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Move Method
def move(board, index, current_player)
  board[index] = current_player
end

# Checks if the position is available
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# Checks user input validity
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Change user input to an integer and match to the available board indexes
def input_to_index(user_input)
  user_input.to_i - 1
end

# Initializes the player turn
def turn(board)
  puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  if !valid_move?(board, index)
      turn(board)
  else
      move(board,index,current_player(board))
      display_board(board)
  end
end

# Player turn helper method
def turn_count(board)
 board.count{|token| token == "X" || token == "O"}
end

# Checks the player turn
def current_player(board)
 if turn_count(board) % 2 ==0
   return "X"
 else
   return "O"
 end
end

# Returns the wining combination
def won?(board)
 WIN_COMBINATIONS.each do |combo|
   if position_taken?(board,combo[0]) && position_taken?(board,combo[1]) && position_taken?(board,combo[2])
     if board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
       return combo
     end
   end
 end
 return false
end

# Checks for a draw game
def draw?(board)
 if won?(board)
   return false
 elsif full?(board)
   return true
 end
end

# Checks for a full board
def full?(board)
    board.each do|i| if (i == nil || " " == i)
       return false
        end
    end
end

# Checks if the game is over
def over?(board)
  draw?(board) || won?(board) || full?(board)
end

# Determines the winner
def winner(board)
  win = won?(board)
  if win
    return board[win[0]]
  end
end

#Initializes the game
def play (board)
 until over?(board)
   turn(board)
 end
 if won?(board)
   puts "Congratulations #{winner(board)}!"
 elsif draw?(board)
   puts "Cats Game!"
 end
end
