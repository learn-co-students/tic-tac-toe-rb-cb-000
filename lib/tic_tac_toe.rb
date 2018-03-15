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

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  board[index] != "" && board[index] != " "
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  cells = board.select do |cell|
    cell == 'O' || cell == 'X'
  end
  return cells.length
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] != "" && board[combination[0]] != " " && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
      return combination
    end
  end
  return false
end

def full?(board)
  board.all? do |cell|
    cell != "" && cell != " "
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  while !over?(board) do
    display_board(board)
    turn(board)
  end
  the_winner = winner(board)
  if the_winner == 'X'
    puts "Congratulations X!"
  elsif the_winner == 'O'
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
end
