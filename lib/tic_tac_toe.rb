# Win combinations constant
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
# Display board method
board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# input_to_index method
def input_to_index(user_input)
    "#{user_input}".chomp.to_i - 1
end

# This method directs the moves
def move(board, position, token)
  board[position] = token
end

# This method returns false if board is not taken and true if its taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Checks if the move is valid
def valid_move?(board, index)
if index.between?(0,8) && !position_taken?(board, index)
    true
  else
    false
  end
end

# Checks the turns if the move is valid
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  token = current_player(board)
  if valid_move?(board,index)
    puts 'valid move'
    move(board, index, token)
    display_board(board)
   else
    puts 'try again'
    turn(board)
  end
  display_board(board)
end

# Turn count method
def turn_count(board)
counter = 0
board.each do | count |
  if count == "X" || count == "O"
    counter += 1
end
end
counter
end

# current_player method
def current_player(board)
  x = turn_count(board) % 2 == 0
if x == true
  "X"
elsif x == false
  "O"
end
end

# win combinations method
def won?(board)
  WIN_COMBINATIONS.detect do | check |

    win_index_1 = check[0]
    win_index_2 = check[1]
    win_index_3 = check[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

if position_taken?(board, win_index_1) && position_taken?(board, win_index_2) && position_taken?(board, win_index_3)

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return check
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return check
    elsif board[WIN_COMBINATIONS[6][0]] == "X" && board[WIN_COMBINATIONS[6][1]] == "X" && board[WIN_COMBINATIONS[6][2]] == "X"
      return [0,4,8]
    elsif board[WIN_COMBINATIONS[6][0]] == "O" && board[WIN_COMBINATIONS[6][1]] == "O" && board[WIN_COMBINATIONS[6][2]] == "O"
      return [0,4,8]
    elsif board[WIN_COMBINATIONS[7][0]] == "X" && board[WIN_COMBINATIONS[7][1]] == "X" && board[WIN_COMBINATIONS[7][2]] == "X"
      return [2,4,6]
    elsif board[WIN_COMBINATIONS[7][0]] == "O" && board[WIN_COMBINATIONS[7][1]] == "O" && board[WIN_COMBINATIONS[7][2]] == "O"
      return [2,4,6]
    else
      return false
  end
end
end
end

# Checks if the board is full.
def full?(board)
  board.all?{|filled| filled == "X" || filled == "O"}
end

# Checks if the board is draw.
def draw?(board)
  if !won?(board) && full?(board)
    puts "This game is draw - sorry ladies and gentlemen"
    return true
  end
end

# Checks if the game is over.
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

# Shows the winning combinations
def winner(board)
  wincombo = won?(board)
  if wincombo === nil
    return nil
  elsif board[wincombo[0]] == "X"
    return "X"
  elsif board[wincombo[0]] == "O"
    return "O"
  end
end

# Play method
def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) === true
    puts "Cat's Game!"
  end
end
