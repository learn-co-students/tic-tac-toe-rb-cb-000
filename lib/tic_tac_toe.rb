# Define Win combinations
WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # lef column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # left to right diagonal
  [2,4,6]  # right to left diagonal
]

# Define and display the board
board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-" * 11
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-" * 11
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Convert user input to index
def input_to_index(input)
  index = input.to_i - 1
end

# Move
def move(board, index, character)
  board[index] = character
end

# Is position taken?
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Is the selection a valid move?
def valid_move?(board, index)
  if position_taken?(board, index) || !index.between?(0, 8)
    return false
  else
    return true
  end
end

# User take their turn
def turn(board)
  character = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board,index)
    move(board,index, character)
    display_board(board)
  else
    turn(board)
  end
end

# Keep track to the turn count
def turn_count(board)
  turns = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      turns +=1
    end
  end
  return turns
end

# Determine current player
def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Is there a winner?
def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    if win_combination.all? do |win_index|
      board[win_index] == "X"
    end
      true
    elsif win_combination.all? do |win_index|
      board[win_index] == "O"
    end
      true
    else
      false
    end
  end
end

# Are all positions on the board full?
def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end

# Is it a draw?
def draw?(board)
  if full?(board) == true && won?(board) == nil
    true
  end
end

# Is the game over?
def over?(board)
  if won?(board) != nil || full?(board) == true || draw?(board) == true
    true
  else
    false
  end
end

# Was the winner X or O?
def winner(board)
  if won?(board) != nil
    board[won?(board).detect {|index| board[index] == "X" || board[index] == "O"}]
  else
    nil
  end
end

# Play
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
  won?(board)
  won?(board)
end
