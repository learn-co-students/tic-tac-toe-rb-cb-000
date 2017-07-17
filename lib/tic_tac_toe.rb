def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # First row
  [1,4,7],  # Second row
  [2,5,8],  # Third row
  [0,4,8],  # Diagonal down
  [2,4,6]  # Diagonal up
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, position)
  board[position] != " " #
end

def valid_move?(board, position)
  !position_taken?(board,position) && position.to_i.between?(0,8)
end

def turn(board)
  puts "Please enter a number 1-9"
  input = input_to_index(gets.strip)
  if valid_move?(board, input)
    move(board,input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
   board.count{|space| space != " "}
end


def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end


def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def full?(board)
  board.all?{|pos| pos != " "}
end

def over?(board)
  draw?(board) || won?(board)
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  end

  if draw?(board)
    puts "Cats Game!"
  end
end
