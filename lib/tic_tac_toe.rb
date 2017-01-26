WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # Second column
  [2,5,8], # Third column
  [0,4,8], #diagonal
  [2,4,6] #other diagonal
]

def display_board(board=[])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_pos)
  user_pos = user_pos.to_i
  user_pos = user_pos - 1
end

def move(board, idx, user_char)
  board[idx] = user_char
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, real_pos)
  if !position_taken?(board, real_pos) && real_pos.between?(0, 8)
    true
  elsif position_taken?(board, real_pos) || !real_pos.between?(0, 8)
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  input = input_to_index(input)
  if valid_move?(board, input)
    user_char = current_player(board)
    move(board, input, user_char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  i = 0
  board.each do |b|
    if b == "X" || b == "O"
      i += 1
    end
  end
  return i
end

def current_player(board)
  c = turn_count(board)
  if c % 2 != 0
    return "O"
  else
    return "X"
  end
end

def won?(board)
	WIN_COMBINATIONS.detect do |combo|
		board[combo[0]] == board[combo[1]] &&
		board[combo[1]] == board[combo[2]] &&
		position_taken?(board,combo[0])
	end
end

def full?(board)
  board.all? { |pos| pos == "X" || pos == "O" }
end

def draw?(board)
  full = full?(board)
  won = won?(board)
  if full && !won
    true
  else
    false
  end
end

def over?(board)
  #returns true if the board has been won, is a draw, or is full.
  if won?(board) || draw?(board) || full?(board)
    true
  end
end

def winner(board)
  win_pos = won?(board)
  if win_pos.kind_of?(Array)
    return board[win_pos[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
  	turn(board)
  end

  if won?(board)
  	win_player = winner(board)
  	puts "Congratulations #{win_player}!"
  elsif draw?(board)
  	puts "Cats Game!"
  end

end
