WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8],
]

def display_board(board)
  row = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts row
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts row
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, position)
  ["X", "O"].include?(board[position])
end

def valid_move?(board, position)
  if position < 0 or position > board.length - 1
    return false
  end
  return !position_taken?(board, position)
end

def turn(board)
  index = -1
  while not valid_move?(board, index)
    puts "Please enter 1-9:"
    index = input_to_index(gets.chomp)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  board.count do |cell|
    ["X", "O"].include?(cell)
  end
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] != " " && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
  end
end

def full?(board)
  board.length == board.count{|cell| cell != " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
