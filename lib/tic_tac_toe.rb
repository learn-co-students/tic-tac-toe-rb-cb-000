
WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,4,8],
[2,4,6],
[0,3,6],
[1,4,7],
[2,5,8]

]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(player_move)
  input = player_move.to_i
  final_move = input - 1
end

def move(board, index, whate)
  board[index] = whate
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  # (board[index] ==  " " || board[index] == "") ?
  # true : false
   index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input2 = gets.strip
  input = input_to_index(input2)

  if !valid_move?(board, input)
    # move(board, converted_input, "X")
    # display_board(board)
    turn(board)
  # else
end
move(board, input, current_player(board))

# display_board(board)
  end

def turn_count(board)
   board.count{|token| token == "X" || token == "O"}
end

# def current_player(board)
#   player = turn_count(board)
#   if player % 2 == 0
#     return "X"
#   else return "O"
#   end
# end

def current_player(board)
   turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  # full?(board) && over?(board) && !won?(board)
  full?(board) && !won?(board)

end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
     if winning_combo = won?(board)
     board[winning_combo.first]
   end
end

def play(board)
  while !over?(board)
     turn(board)
   end
     if won?(board)
       puts "Congratulations #{winner(board)}!"
     elsif draw?(board)
       puts "Cat's Game!"
   end
end
