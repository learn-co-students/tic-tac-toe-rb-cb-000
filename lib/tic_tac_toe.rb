# Print out the current tic tac toe board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# returns board index from user input
def input_to_index(input)
  input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def won?(board)
  WIN_COMBINATIONS.find do |win_combination|
    board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X" or board[win_combination[0]] == "O" && board[win_combination[1]] =="O" && board[win_combination[2]] == "O"
  end
end

def full?(board)
  board.none? {|position| position == " "}
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  else
    nil
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && board[index] == " "
    true
  else
    false
  end
end

def turn(board)
  puts "Enter a position, from 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    if current_player(board) == 'X'
      move(board, index, 'X')
    else
      move(board, index, 'O')
    end
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    'X'
  else
    'O'
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  end
  puts "Congratulations #{winner(board)}!"
end
