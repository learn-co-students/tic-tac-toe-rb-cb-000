WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]
#################################
board = [" "," "," ",
         " "," "," ",
         " "," "," ",]
##################################
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
##################################
def input_to_index(input)
  index = input.to_i - 1
  index
end
##################################
def move(board, index, value)
  board[index] = value
end
##################################
def position_taken?(board, index)
  if board[index] == 'X' || board[index] == 'O'
    true
  elsif board[index] == ' ' || board[index] == '' || board[index] ==nil
    false
  end
end
##################################
def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    true
  else
    false
  end
end
##################################
def turn(board)
  puts 'Please enter 1-9:'
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    value = current_player(board) ##
    move(board, index, value)
  else
    turn(board)
  end
  display_board(board)
end
##################################
def turn_count(board)
  counter = 0
  board.each do |turn|
    counter += 1 if turn == 'X' || turn == 'O'
  end
  counter
end
###################################
def current_player(board)
  if turn_count(board).even?
    'X'
  else
    'O'
  end
end
####################################
def won?(board)
  winner = false
  for win in WIN_COMBINATIONS
    win_index_1 = win[0]
    win_index_2 = win[1]
    win_index_3 = win[2]

    pos_1 = board[win_index_1]
    pos_2 = board[win_index_2]
    pos_3 = board[win_index_3]

    if (pos_1 == 'X' && pos_2 == 'X' && pos_3 == 'X') || (pos_1 == 'O' && pos_2 == 'O' && pos_3 == 'O')
      return win
    else
      false
    end
  end
  winner
end
#####################################
def full?(board)
  board.all? do |place|
    true if place == 'X' || place == 'O'
  end
end
####################################
def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end
###################################
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end
###################################
def winner(board)
  last1 = won?(board)
  if last1
    board[last1[-1]]
  end
end
####################################
def play(board)
  until over?(board)
    turn(board)
    won?(board)
    draw?(board)
  end
  winning_player = winner(board)
  if winning_player
    puts "Congratulations #{winning_player}!"
  else
    puts "Cats Game!"
  end
end
