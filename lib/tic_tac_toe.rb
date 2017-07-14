WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #first column
  [1, 4, 7], #middle column
  [2, 5, 8], #last column
  [0, 4, 8], #diagonal 1
  [2, 4, 6], #diagonal 2
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input = (user_input.to_i) - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    true
  elsif board[index] == " " || board[index] = "" || board[index] == nil
    false
  else
  end
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets
  index = input_to_index(user_input)
  if valid_move?(board, index)
    puts "Great move!"
    move(board, index, current_player(board))
    display_board(board)
  else
      puts "Invalid move! Choose a number between 1 - 9 or a spot that has not yet been taken"
        turn(board)
  end
end


def turn_count(board)
  turns = 0
  board.each do |token|
    if token == "X" || token == "O"
    turns +=1
  end
  end
  turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |winner|
    if board[winner[0]] == board[winner[1]] && board[winner[1]] == board[winner[2]] && position_taken?(board, winner[0])
      true
    else
      false
    end
  end
end

def full?(board)
  board.all? do |token|
    token == "X" || token == "O"
  end
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  draw?(board) || full?(board) || won?(board)
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
  puts "Cats Game!"
end
end
