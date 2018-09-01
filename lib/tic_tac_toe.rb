WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

board= [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index=input.to_i-1
end

def position_taken?(board, position)
  if board[position]=="X" || board[position]== "O"
    return true
  else
    return false
  end
end

def move(board, index, value)
  board[index]=value
end

def valid_move?(board, index)
  if index.between?(0,8) == true && (position_taken?(board, index) == false)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
input=gets.chomp
index=input_to_index(input)
  if valid_move?(board, index) == false
  turn(board)
else
  move(board, index, current_player(board))
  display_board(board)
end
end

def turn_count(board)
  counter=0
  board.each do |place|
    if place == "X" || place == "O"
      counter+=1
  end
end
    return counter
end

def current_player(board)
  board.each do |place|
    if turn_count(board) % 2 == 0
      return "X"
    else
      return "O"
    end
  end
end

def won?(board)
  count=0
  if WIN_COMBINATIONS.each do |index|
  win_one = index[0]
  win_two = index[1]
  win_three = index[2]
  place_1 = board[win_one]
  place_2 = board[win_two]
  place_3 = board[win_three]
  if place_1 == "X" && place_2 == "X" && place_3 == "X"
    count+=1
    return index
  elsif place_1 == "O" && place_2 == "O" && place_3 == "O"
    count+=1
    return index
  end
end
  if count=0
    return false
end
end
end

def full?(board)
  i=0
  board.each do |index|
    if index == "X" || index == "O"
    i+=1
    end
  end
    if i==9
      return true
    else
      return false
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
end
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
     return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
  won?(board).each do |i|
    if board[i] == "O"
      return "O"
    else
      return "X"
    end
 end
else
    return nil
  end
end

def play(board)
  while over?(board) == false
    turn(board)
    won?(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
end
