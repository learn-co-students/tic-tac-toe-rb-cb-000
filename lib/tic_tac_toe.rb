
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  separator = "-----------"

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts separator
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts separator
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def won?(board)
  # check if board is empty and return false if so
  if board.all?{|i| i == " "}
    return false
  end

  WIN_COMBINATIONS.each do |win_combination|
    if check_for_win(board, win_combination)
      return win_combination
    end
  end

  if full?(board)
    false
  end

end

def draw?(board)
  winner = won?(board)
  full_board = full?(board)
  if !winner && full_board
    true
  elsif !winner && !full_board
    false
  elsif winner
    false
  end
end

def full?(board)
  if board.all?{|i| i != " "}
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end

def winner(board)
  if !won?(board)
    return nil
  else
    winning_comb = won?(board)
    winner_symbol = board[winning_comb[0]]
    return winner_symbol
  end
end

def current_player(board)
  if turn_count(board) == 0
    "X"
  elsif turn_count(board) == 1
    "O"
  elsif turn_count(board) == 2
    "X"
  elsif turn_count(board) == 3
    "O"
  elsif turn_count(board) == 4
    "X"
  elsif turn_count(board) == 5
    "O"
  elsif turn_count(board) == 6
    "X"
  elsif turn_count(board) == 7
    "O"
  elsif turn_count(board) == 8
    "X"
  end
end

def check_for_win(board, win_combination)
  position_1 = board[win_combination[0]]
  position_2 = board[win_combination[1]]
  position_3 = board[win_combination[2]]
  win = false

  if position_taken?(board,win_combination[0]) && position_taken?(board,win_combination[1]) && position_taken?(board,win_combination[2])
    if position_1 == position_2 && position_1 == position_3 && position_2 == position_3
      win = true
    end
  end
  win
end

def turn_count(board)
  occupied_fields_count = 0
  board.each do |field|
    if field == "X" || field == "O"
      occupied_fields_count += 1
    end
  end
  occupied_fields_count
end

def play(board)
  round = 0
  until over?(board) == true
    turn(board)
    round += 1
  end
  
  if won?(board)
    symbol = winner(board)
    puts "Congratulations #{symbol}!"
  elsif draw?(board)
     puts "Cats Game!"
  end
end
