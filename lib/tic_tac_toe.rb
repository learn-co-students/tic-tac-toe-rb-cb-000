# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # botton row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # left diag
  [2,4,6], # right diag
]

#Define a method that prints the current board representation based on the `board` argument passed to the method.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#This method takes the user_input (which is a string), converts it to an Integer, and subtracts 1.
def input_to_index(user_input)
  a = user_input.to_i
  user_input = a - 1
  return user_input
end

#Your `#move` method must take in three arguments:
#**1)** the board array,
#**2)** the index in the board array that the player would like to fill out with an "X" or and "O", and
#**3)** the player's character (either "X" or "O").
def move(array,
  index, current_player)
  array[index]= current_player
end

#The `#position_taken?` method will be responsible for evaluating the position selected by the user against the Tic Tac Toe board and checking to see whether or not that index on the board array is occupied.
def position_taken?(board,index)
  ["X", "O"].include?(board[index])
end

#Build a method `valid_move?` that accepts a board and an index to check and returns `true` if the move is valid and `false` or `nil` if not.
def valid_move?(board,index)
	if index.between?(0,8) && position_taken?(board,index) == false
		true
	else
		false
  end
end

#Build a method `#turn` to encapsulate the logic of a single complete turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board, index, current_player(board))
    display_board(board)
  else turn(board)
  end
end

#This method takes in an argument of the board array and returns the number of turns that have been played.
def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " "
      counter += 1
    else
      counter += 0
    end
  end
    return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Define if there is a win on the board
def won?(board)
  WIN_COMBINATIONS.detect do |win|
    if (board[win[0]]) == "X" && (board[win[1]]) == "X" && (board[win[2]]) == "X"
      return win
    elsif (board[win[0]]) == "O" && (board[win[1]]) == "O" && (board[win[2]]) == "O"
      return win
    end
  end
end

# Define if the board is full
def full?(board)
   board.none?{ |space| space == " "}
end

#Define a draw
def draw?(board)
  (won?(board))== nil && (full?(board))== true
end

#Define if the game is over if the board has been won, is a draw, or is full
def over?(board)
  draw?(board) || full?(board) || won?(board)
end

#Define the winner!
def winner(board)
  WIN_COMBINATIONS.detect do |win|
    if (board[win[0]]) == "X" && (board[win[1]]) == "X" && (board[win[2]]) == "X"
      return "X"
    elsif (board[win[0]]) == "O" && (board[win[1]]) == "O" && (board[win[2]]) == "O"
      return "O"
    end
  end
end

def play(board)
  until over?(board)
    current_player(board)
    turn(board)
  end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cat's Game!"
    end
end
