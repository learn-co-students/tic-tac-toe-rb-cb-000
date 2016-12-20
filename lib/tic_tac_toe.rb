# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,3,6], #First column
  [1,4,7], #Second column
  [2,5,8], #Third column
  [0,4,8], #First diagonal
  [2,4,6], #Second diagonal
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  #puts "A Tic Tac Toe Board"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(number)
  number = number.to_i
  number = number - 1
end

def move(array, index, value)
  array[index] = value
end

# code your #position_taken? method here!
def position_taken? (board, index)
  if board[index] == ""
    false
  elsif board[index] == " "
    false
  elsif board[index] == nil
    false
  elsif (board[index] == "X") || (board[index] == "O")
    true
  end
end

# code your #valid_move? method here
def valid_move? (board, index)
  if index.between?(0, 8)
     if position_taken?(board, index)
       false
     else
       true
     end
  else
     false
  end
end

#def turn(board)
#  puts "Please enter 1-9:"
#  input = gets.strip
#  index = input_to_index(input)
#  if valid_move?(board, index)
#    move(board, index, value)
#    display_board(board)
#  else
#    turn(board)
#  end
#end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
    if turn_count(board) % 2 == 0
      return "X"
    else
      return "O"
    end
end

def turn(board)
  value = current_player(board)

  puts "Please enter 1-9:"
  number = gets.strip

  index = input_to_index(number)
  valid = valid_move?(board, index)

  if valid == false
    while valid == false
      puts "Please enter 1-9:"
      second_pass = gets.strip
      valid = valid_move?(board, input_to_index(second_pass))
    end
  end

  move(board, index, value)
  display_board(board)

end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|

    check_board = [board[win_combination[0]], board[win_combination[1]], board[win_combination[2]]]
    if
      check_board.all? do |check|
        check == "X"
      end
      return win_combination
    elsif
      check_board.all? do |check|
        check == "O"
      end
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.all? do |position|
    !(position == " ")
  end
end

def draw?(board)
  if
    !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if
    !won?(board) == false || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  check = won?(board)
  if check == false
    return nil
  elsif [board[check[0]], board[check[1]], board[check[2]]].include?("X")
    return "X"
  elsif [board[check[0]], board[check[1]], board[check[2]]].include?("O")
    return "O"
  end
end

#def play(board)
#  player_turn = 1
#  while player_turn < 10
#    turn(board)
#    player_turn = player_turn + 1
#  end
#end

def play(board)
  #player_turn = 1
  #while player_turn < 10 && !over?(board)
  while over?(board) == false
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end

end
