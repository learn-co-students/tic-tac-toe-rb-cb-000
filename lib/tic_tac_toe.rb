WIN_COMBINATIONS = [
  #linear
  [0,1,2],
  [3,4,5],
  [6,7,8],
  #Cross
  [0,4,8],
  [2,4,6],
  #Horizontal
  [0,3,6],
  [1,4,7],
  [2,5,8],
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

def move(board, index, current_player)
board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#Turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    puts display_board(board)
  else
    turn(board)
  end
end

#Play
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

def turn_count(board)
  board.count { |x| x == "X" || x == "O" }
end


def current_player(board)
  if turn_count(board).even?
    current_player = "X"
  else
    current_player = "O"
 end
end

def won?(board)
win_combination_1 = WIN_COMBINATIONS[0]
win_combination_2 = WIN_COMBINATIONS[1]
win_combination_3 = WIN_COMBINATIONS[2]
win_index_1 = win_combination_1
win_index_2 = win_combination_2
win_index_3 = win_combination_3

position_1 = board[win_index_1[0]]
position_2 = board[win_index_1[1]]
position_3 = board[win_index_1[2]]
position_4 = board[win_index_2[0]]
position_5 = board[win_index_2[1]]
position_6 = board[win_index_2[2]]
position_7 = board[win_index_3[0]]
position_8 = board[win_index_3[1]]
position_9 = board[win_index_3[2]]

#Horizontal
if position_1 == "X" && position_2 == "X" && position_3 == "X"
  return true
elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
  return true

elsif position_4 == "X" && position_5 == "X" && position_6 == "X"
  return true
elsif position_4 == "O" && position_5 == "O" && position_6 == "O"
  return true

elsif position_7 == "X" && position_8 == "X" && position_9 == "X"
  return true
elsif position_7 == "O" && position_8 == "O" && position_9 == "O"
  return true

#vertical

elsif position_1 == "X" && position_4 == "X" && position_7 == "X"
  return true
elsif position_1 == "O" && position_4 == "O" && position_7 == "O"
  return true

elsif position_2 == "X" && position_5 == "X" && position_8 == "X"
  return true
elsif position_2 == "O" && position_5 == "O" && position_8 == "O"
  return true

elsif position_3 == "X" && position_6 == "X" && position_9 == "X"
  return true
elsif position_3 == "O" && position_6 == "O" && position_9 == "O"
  return true

#diagonal

elsif position_1 == "X" && position_5 == "X" && position_9 == "X"
  return true
elsif position_1 == "O" && position_5 == "O" && position_9 == "O"
  return true

elsif position_3 == "X" && position_5 == "X" && position_7 == "X"
  return true
elsif position_3 == "O" && position_5 == "O" && position_7 == "O"
  return true

else false
    end
end

def full?(board)
if board.all? { |i| i != " " }
  true
else
  false
  end
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board) == false
    false
  else
    true
  end
end

def over?(board)
  if won?(board)
    true
  elsif draw?(board)
    true
  else
    false
  end
end

def winner(board)

  win_combination_1 = WIN_COMBINATIONS[0]
  win_combination_2 = WIN_COMBINATIONS[1]
  win_combination_3 = WIN_COMBINATIONS[2]
  win_index_1 = win_combination_1
  win_index_2 = win_combination_2
  win_index_3 = win_combination_3

  position_1 = board[win_index_1[0]]
  position_2 = board[win_index_1[1]]
  position_3 = board[win_index_1[2]]
  position_4 = board[win_index_2[0]]
  position_5 = board[win_index_2[1]]
  position_6 = board[win_index_2[2]]
  position_7 = board[win_index_3[0]]
  position_8 = board[win_index_3[1]]
  position_9 = board[win_index_3[2]]

  if won?(board) && position_1 == "X" && position_2 == "X" && position_3 == "X"
      return "X"
  elsif won?(board) && position_1 == "O" && position_2 == "O" && position_3 == "O"
      return "O"

  elsif won?(board) && position_4 == "X" && position_5 == "X" && position_6 == "X"
      return "X"
  elsif won?(board) && position_4 == "O" && position_5 == "O" && position_6 == "O"
    return "O"

  elsif won?(board) && position_7 == "X" && position_8 == "X" && position_9 == "X"
    return "X"
  elsif won?(board) && position_7 == "O" && position_8 == "O" && position_9 == "O"
    return "O"

  #vertical

  elsif won?(board) && position_1 == "X" && position_4 == "X" && position_7 == "X"
    return "X"
  elsif won?(board) && position_1 == "O" && position_4 == "O" && position_7 == "O"
    return "O"

  elsif won?(board) && position_2 == "X" && position_5 == "X" && position_8 == "X"
    return "X"
  elsif won?(board) && position_2 == "O" && position_5 == "O" && position_8 == "O"
    return "O"

  elsif won?(board) && position_3 == "X" && position_6 == "X" && position_9 == "X"
    return "X"
  elsif won?(board) && position_3 == "O" && position_6 == "O" && position_9 == "O"
    return "O"

  #diagonal

  elsif won?(board) && position_1 == "X" && position_5 == "X" && position_9 == "X"
    return "X"
  elsif won?(board) && position_1 == "O" && position_5 == "O" && position_9 == "O"
    return "O"

  elsif won?(board) && position_3 == "X" && position_5 == "X" && position_7 == "X"
    return "X"
  elsif won?(board) && position_3 == "O" && position_5 == "O" && position_7 == "O"
    return "O"

  else nil
      end
  end
