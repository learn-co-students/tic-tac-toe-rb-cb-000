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

 def move(board, index, current_player)
   board[index] = current_player
 end

 def position_taken?(board, location)
   board[location] != " " && board[location] != ""
 end

 def valid_move?(board, index)
   index.between?(0,8) && !position_taken?(board, index)
 end

 def turn(board)
   puts "Please enter 1-9:"
   input = gets.strip
   index = input_to_index(input)
   if valid_move?(board, index)
     move(board, index, current_player(board))
     display_board(board)
   else
     turn(board)
   end
 end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" or position == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  elsif turn_count(board).odd?
    "O"
  end
end

WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #diagonal1
  [2,4,6]  #diagonal2
]

def won?(board)
  WIN_COMBINATIONS.detect do |win|
    position1 = board[win[0]]
    position2 = board[win[1]]
    position3 = board[win[2]]
    if position1 == position2 && position2 == position3 && position1 != " "
      return win
    else
      false
    end
  end
end

def full?(board)
  board.none?{|position| position == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  win_combo = won?(board)
  if won?(board)
    win_location = win_combo[0]
    board[win_location]
  end
end
