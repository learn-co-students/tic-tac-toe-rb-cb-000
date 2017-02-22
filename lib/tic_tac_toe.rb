# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[2,4,6],[0,4,8]]

#defines the variable board below.
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index (input)
  index = input.to_i
  index - 1
 end


def move (board, index, char)
  board[index] = char
    end

# code your #position_taken? method here!
def position_taken?(board, i)
  if board[i] == " " || board[i] == ""
         false
      elsif board[i] == nil
         false
      elsif
        board[i] == "X" || board[i] == "O"
         true
      end
    end

# code your #valid_move? method here
def valid_move?(board, i)
  if i.between?(0,8) && !position_taken?(board, i)
        true
     end
    end

# code your #turn method here
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "Incorrect entry. Try again."
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

 def won?(board)
   WIN_COMBINATIONS.find do |win_combo|
      board[win_combo[0]] == board[win_combo[1]] && board[win_combo[1]] == board[win_combo[2]] && position_taken?(board,win_combo[0])
   end
 end

 def full?(board)
   board.all? do |board_element|
     board_element =="X" || board_element == "O"
   end
 end

 def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
 end

 def over?(board)
   won?(board) || draw?(board) || full?(board)
 end

 def winner(board)
   if index = won?(board)
     board[index.last]
   end
 end

 # Define your play method below
 def play(board)
    while !over?(board)
      turn(board)
    end
      if won?(board)
        puts "Congratulations #{winner(board)}!"
      elsif
        draw?(board)
        puts "Cats Game!"
      end
    end
