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
  return input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  return board[index] != " "
end

def valid_move?(board, index)
  return index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Enter a position 1 - 9"
  input = gets.chomp
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    puts display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  return board.count{ |x| x != " " }
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each { |x|
    return x if x.all? { |y| board[y] == "X" } || x.all? { |y| board[y] == "O" }
  }
    return false
end

def full?(board)
  return board.all? { |x| x != " " }
end

def draw?(board)
  return full?(board) && !won?(board) ? true : false
end

def over?(board)
  return won?(board) || draw?(board) || full?(board) ? true : false
end

def winner(board)
  winning_combo = won?(board)
  return !winning_combo ? nil : board[winning_combo.first]
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
