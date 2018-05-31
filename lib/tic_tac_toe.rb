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

def move (board, index, character)
  board[index] = character
end

def valid_move?(board, index)
  if(index < 0 || index > 8)
    return false
  elsif((index >= 0 || index < 9) && !(position_taken?(board,index)))
    return true
  end
end

def position_taken?(board, index)
  if(board[index] == " " || board[index] == "" || board[index] == nil)
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  until valid_move?(board,index) do
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    break
  end
  # character = board[index]
  # move(board,index,character)
  character = current_player(board)
  move(board,index,character)
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |element|
    if(element == "X" || element == "O")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if(turn_count(board) == 0)
    return "X"
  elsif(turn_count(board) % 2 != 0)
    return "O"
  else
    return "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]
    if(position_1 == "X" && position_2 == "X" && position_3 == "X")
      return win_combination
    end
    if(position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  return false
end

def full?(board)
  full = false
  board.each do |element|
    if(element == "X" || element == "O")
      full = true
    else
      full = false
    end
  end
  return full
end

def draw?(board)
  if(!won?(board) && full?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if(won?(board) || full?(board) || draw?(board))
    return true
  else
    return false
end
end

def winner(board)
  if(won?(board))
    if(board[won?(board)[0]] == "X")
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until over?(board) do
  turn(board)
  end
  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif(draw?(board))
    puts "Cat's Game!"
  end
end
  
