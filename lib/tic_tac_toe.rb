WIN_COMBINATIONS = [
[0,1,2], #top rows
[3,4,5], #middle row
[6,7,8], #bottom row
[0,3,6], #left_down
[1,4,7], #middle_down
[2,5,8], #right_down
[0,4,8], #across_right
[6,4,2] #across_left
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  index = user_input.to_i - 1
  return index
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == ""
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |count|
    if count == "X" || count == "O"
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

def won?(board)
  WIN_COMBINATIONS.detect do |winner_combo|
    win_index_1 = winner_combo[0]
    win_index_2 = winner_combo[1]
    win_index_3 = winner_combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return winner_combo
    end
  end
end

def full?(board)
  board.each do |filled|
    if filled == " " || filled == ""
      return false
    end
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if (won?(board))
    winner_combo = won?(board)
    return board[winner_combo[0]]
  else
    return nil
  end
end

def play(board)
  counter = 0
  while counter < 9 && !over?(board)
    turn(board)
    counter+=1
  end
  gameWinner = winner(board)
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{gameWinner}!"
  end
end
