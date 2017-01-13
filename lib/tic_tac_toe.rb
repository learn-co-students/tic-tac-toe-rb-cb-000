# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

# Takes board and prints it out formatted
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  index = input.to_i
  index - 1
end

# Places character at index on given board
def move(board, index, character)
  board[index] = character
end

# code your #valid_move? method here
def valid_move?(board, position)
  if !position.between?(0, 8)
    puts "Invalid move."
    return false
  elsif position_taken?(board, position)
    return false
  else
    return true
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  if board[index] == "X"
    return true
  elsif board[index] == "O"
    return true
  elsif board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  end
end

# If position is on board && position is not taken, returns true
def valid_move?(board, position)
  if !position.between?(0, 8)
    puts "Invalid move."
    return false
  elsif position_taken?(board, position)
    return false
  else
    return true
  end
end

# Asks for & gets input, the moves to position on board
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets
  index = input_to_index(user_input)

  if valid_move?(board,index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Returns number of turns that've PASSED
def turn_count(board)
  num_turns = 0

  board.each do |space|
    if space == "X" || space == "O"
      num_turns += 1
    end
  end

  return num_turns
end

# Returns "X" if num of turns is even or "O" if false
def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

# won?
def won? (board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination # return the win_combination indexes that won.
    end

    if position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
    end
  end

  return false
end

# full?
def full? (board)
  if board.include? ''
    return false
  elsif board.include? ' '
    return false
  else
    return true
  end
end

# draw?
def draw? (board)
  # Won, return false
  if won?(board)
    return false
  # Not won and full, return true
  elsif full?(board)
    return true
  # Not won & not full, return false
  else
    return false
  end
end

# over?
def over?(board)
  return won?(board) || draw?(board) || full?(board)
end

# winner
def winner (board)
  if won?(board)
    win_combination = won?(board)
    return board[win_combination[0]]
  else
    return nil
  end
end

# Main game loop
def play(board)
  display_board(board)

  until over?(board)
    turn(board)
  end

  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  elsif draw?(board)
    puts "Cats Game!"
  end
end
