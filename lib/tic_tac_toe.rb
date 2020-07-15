 WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 4, 8], # Top-Bottom Diagonal
  [6, 4, 2], # Bottom-Top Diagonal
  [0, 3, 6], # Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], # Right column
]

board = [" "," "," "," "," "," "," "," "," " ]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
  return index
end   

def move(board, index, current_player)
  board[index] = current_player
end   

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
    
  elsif board[index] == "X" || board[index] == "O"
    true
  else puts "please enter 1-9:"
  end  
end   

def valid_move?(board, index)
  if index <= 8 && index >= 0 && !position_taken?(board, index)
    true
  else puts "Please enter 1-9:"
  end  
end

def turn(board)
  puts "Please enter 1-9:"
  
  user_input = gets.strip
  index = input_to_index(user_input)
  
  if valid_move?(board, index) && !position_taken?(board, index)
    move(board, index, current_player(board))
    display_board(board)
    
  else valid_move?(board, index) && !position_taken?(board, index)
    turn(board)
  end  
end

def turn_count(board)
  counter = 0
  board.each do |turn|
  if turn == "O" || turn == "X"
    counter += 1
  end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 == 1
    return "O"
  end  
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] && 
    position_taken?(board, combo[0])
  end  
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end  
end

def play(board)
  until over?(board)
  turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
    
  end
end 