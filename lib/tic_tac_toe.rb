WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8], #bottom row win
  [0,3,6],
  [1,4,7],
  [2,5,8], #right column win
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    true
  else
    false
  end
end

def input_to_index(user_input)
  user_input = user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |play|
    if play != " "
      turns += 1
    end
  end
  turns
end

def current_player(board)
  player = "X"
  if turn_count(board) % 2 != 0
    player = "O"
  end
  player
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    if position_taken?(board, win_combo[0])
      board[win_combo[0]] == board[win_combo[1]] && board[win_combo[0]] == board[win_combo[2]]
    end

  end
end
#
#
 def full?(board)
  board.all? { |position| position == "X" || position == "O" }
end

def draw?(board)
  if !won?(board)
    if full?(board)
      true
    else
      false
    end
  else
    false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end

def winner(board)
  if won?(board) != nil
    winner = board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
