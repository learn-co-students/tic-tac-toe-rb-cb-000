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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, position)
  board[index] = position
end

def position_taken?(board,index)
  if board[index] == " "
    false
  elsif board[index] == ""
    false
  elsif board[index] == "X"
    true
  elsif board[index] == "O"
    true
  else
    false
  end
end

def valid_move?(board, index)
  if position_taken?(board,index) == false && index <= 8 && index >=0
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    position = current_player(board)
    move(board, index, position)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn = 0
  board.each do |move|
    if move == "X" or move == "O"
      turn += 1
    else
    end
  end
  turn
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |x|
    if board[x[0]] == "X" && board[x[1]] == "X" && board[x[2]] == "X"
      champ = "X"
      return x
    elsif board[x[0]] == "O" && board[x[1]] == "O" && board[x[2]] == "O"
      return x
    end
  end
  return
end

def full?(board)
  board.all? do |y|
    y == "X" or y == "O"
  end
end

def draw?(board)
  if won?(board) != nil
    return false
  elsif full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) or draw?(board) or full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == nil
    return nil
  else
    win_combo = won?(board)
    return board[win_combo[0]]
  end
end


def play(board)
  while over?(board) == false
    turn(board)
    end
  if won?(board) != nil
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end

# board = [" "," "," "," "," "," "," "," "," "]
# board = [" "," "," ","X","X","X"," "," "," "]
# board = ["X","X","X","X","X","X","X","X","X"]
