WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,4,8,], [2,4,6], [0,3,6], [1,4,7], [2,5,8]]

def display_board(board)
  
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input) 
  input = input.to_i - 1 
end

def move(board, index, value)
  board[index] = value
end
  
def position_taken?(board, index)
  (board[index] != " " && board[index] != "" && board[index] != nil)
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  if valid_move?(board, index)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |index|
    if index == "X" || index == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else turn_count(board) % 2 != 0 
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|      # code will iterate each indexed value[] and return first instance in which the first index is equal to the value of "X" and store in the array win_combination else it will not return a value at all
    if (board[win_combination[0]]) == "X" && (board[win_combination[1]]) == "X" && (board[win_combination[2]]) == "X"
      return win_combination
    elsif  (board[win_combination[0]]) == "O" && (board[win_combination[1]]) =="O" && (board[win_combination[2]]) == "O"
    return win_combination
  end
  false
end
end

def full?(board)
  board.all?{|taken_space| taken_space != " "} 
end
  
def draw?(board)
  !(won?(board)) && (full?(board))
end

def over?(board)
  (won?(board)) || (draw?(board))
end

def winner(board)
  WIN_COMBINATIONS.detect do |win_combination|      # code will iterate each indexed value[] and return first instance in which the first index is equal to the value of "X" and store in the array win_combination else it will not return a value at all
    if (board[win_combination[0]]) == "X" && (board[win_combination[1]]) == "X" && (board[win_combination[2]]) == "X"
      return "X"
    elsif  (board[win_combination[0]]) == "O" && (board[win_combination[1]]) =="O" && (board[win_combination[2]]) == "O"
    return "O"
  else 
    nil
  end
end
end

def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
    puts "Cat's Game!"
  end
end
