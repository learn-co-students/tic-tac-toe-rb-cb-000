

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def x_won?(win_combo, board)
  win_combo.all? do |index|
    board[index] == "X"
  end
end

def o_won?(win_combo, board)
  win_combo.all? do |index|
    board[index] == "O"
  end
end

def won?(board)
  winner = []
  WIN_COMBINATIONS.each do |win_combo|
    if x_won?(win_combo, board) == true
      winner = win_combo
    elsif o_won?(win_combo, board) == true
      winner = win_combo
    end
  end
  if winner == []
    return false
  end
  return winner
end

def full?(board)
  board.all? do |space|
    space == 'X' || space == 'O'
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != false
    return true
  elsif full?(board) == true
    return true
  elsif draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  value = won?(board)
  if value == false
    return nil
  else
    something = value[0]
    spot = board[something]
    if spot == "X"
      return "X"
    else
      return "O"
    end
  end
end

def input_to_index(input)
  index = input.to_i - 1
  return index
end

def valid_move?(board, index)
  spot = board[index]
  if index > 8 || index < 0 || index % 1 != 0
    return false
  elsif spot == "" || spot == " " || spot == nil
    return true
  else
    return false
  end
end

def move(board, index, token)
  board[index] = token
end

def turn(board)
  dex = 0
  token = current_player(board)
  loop do
    puts "Please enter 1-9:"
    input = gets
    dex = input_to_index(input)
    break if valid_move?(board, dex)
  end
  move(board, dex, token)
  display_board(board)
end

def turn_count(board)
  turn = 0
  board.each do |spot|
    if spot == " " || spot == "" || spot == nil
      turn += 0
    else
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  turns_elapsed = turn_count(board)
  if turns_elapsed % 2 != 0
    player = "O"
  else
    player = "X"
  end
  return player
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if winner(board) == nil
    puts "Cat's Game!"
  elsif winner(board) == "X"
    puts "Congratulations X!"
  else
    puts "Congratulations O!"
  end
end
