# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7],  # Middle column
  [2,5,8], # Right row
  [0,4,8], # Horizontal left to right
  [2,4,6]  # Horizontal right to left
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  if board[index] == 'X' || board[index] == 'O'
    return false
  elsif index >=0 && index <=8
      return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.chomp)
  current_player = current_player(board)
  if valid_move?(board, index) == true
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_count = 0
  board.each do |move|
    if move != " "
      turn_count +=1
    end
  end
  return turn_count
end

def current_player(board)
  x_moves = 0
  o_moves = 0
  board.each do |move|
    if move == "X"
      x_moves += 1
    elsif move == "O"
      o_moves += 1
    end
  end
  if x_moves > o_moves
    return "O"
  else
    return "X"
  end
end

def won?(board)
  x_positions = []
  o_positions = []
  board.each_index do |position|
    if board[position] == "X"
      x_positions << position
    elsif board[position] == "O"
      o_positions << position
    end
  end
  WIN_COMBINATIONS.each do |win_combo|
    if (win_combo - x_positions).empty? || (win_combo - o_positions).empty?
      return win_combo
    end
  end
  return false
end

def full?(board)
  empty_spaces = 0
  board.each do |position|
    if position == " "
      empty_spaces += 1
    end
  end

  if empty_spaces > 0
    return false
  else
    return true
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  else
    return
    false
  end
end

def winner(board)
  x_positions = []
  o_positions = []
  board.each_index do |position|
    if board[position] == "X"
      x_positions << position
    elsif board[position] == "O"
      o_positions << position
    end
  end
  WIN_COMBINATIONS.each do |win_combo|
    if (win_combo - x_positions).empty?
      return "X"
    elsif (win_combo - o_positions).empty?
      return "O"
    end
  end
  return nil
end

def play(board)
  until over?(board) do
    turn(board)
  end
  winner = winner(board)
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner}!"
  end
end
