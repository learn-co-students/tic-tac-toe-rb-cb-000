WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
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
  
def move(board, position, character)
  board[position] = character
end
  
def position_taken?(board, position)
  board[position] == "X" || board[position] == "O"
end
  
def valid_move?(board, position)
    position.between?(0,8) && !position_taken?(board, position)
  end
  
def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end
  

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    tiles_to_check = board.values_at(*combination)
    if tiles_to_check.all?{ |obj| obj == "X"}  || tiles_to_check.all?{ |obj| obj == "O"}
      return combination
    end
  end
  return nil
end

def full?(board)
  board.all? { |obj| obj == "X" || obj == "O" }
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  result = won?(board)
  if result
    board.values_at(*result)[0]
  else nil
  end
end
  
def play(board)
  until over?(board)
    turn(board)
    if draw?(board)
      break
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
  