WIN_COMBINATIONS = [
[0,1,2], #verticals
[3,4,5],
[6,7,8],

[0,3,6], #horizontals
[1,4,7],
[2,5,8],

[0,4,8], #diagonals
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

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == ' ' || board[index] == '' || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)  #needs to return True/False based on position   .empty? doesn't work though
  (0..8).include?(index) && board[index] == ' '
end

value = 'X' || 'O'


def turn(board)
  puts "Please enter 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
   move(board, index, current_player(board))
   display_board(board)
 else
   turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |element|
    if element == "O" || element == "X"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)  #  expected: at least 3 times with any arguments. Received: 2 times with any arguments
  WIN_COMBINATIONS.find do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] && board[win_combo[0]] == board[win_combo[2]] && position_taken?(board, win_combo[1])
  end
end

def full?(board)  #it will still return true because there will be empty spaces. Try checking if all positions are filled.
  board.none? do |i|
    i == " " || i.nil?
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def winner(board)
  if won?(board) != nil
    winner = board[won?(board)[0]]
  end
end

def over?(board)
  draw?(board) == true || won?(board) != nil
end

def play(board)
  until over?(board) do
    turn(board)
  end
if draw?(board)
puts "Cats Game!"
else
  puts "Congratulations #{winner(board)}!"
end
end
  # print "Congratulations #{current_player(board)}"


board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

play(board)
