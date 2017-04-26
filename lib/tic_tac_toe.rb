##Win circumstances
WIN_COMBINATIONS = [
  [0,1,2], #Top horizontal
  [3,4,5], #Middle horizontal
  [6,7,8], #Bottom horizontal
  [0,3,6], #Left vertical
  [1,4,7], #Middle vertical
  [2,5,8], #Right vertical
  [0,4,8], #Left corner diagonal
  [2,4,6] #Right corner diagonal
]

def display_board(board)
  puts row = " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts row = " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts row = " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Convert input to index number
def input_to_index(input)
  index = input.to_i - 1
end

#Fill in board array with tokens(X,O)
def move(board,index,token)
  board[index] = token
  display_board(board)
end

#Helper to valid_move
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#Is move valid?
def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
  else
    turn(board)
  end
end

##Number of turns that have been played
def turn_count(board)
  counter = 0
  board.each do |member|
    if member == "X" || member == "O"
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end


##DETERMINE WINS##
def won?(board)
  WIN_COMBINATIONS.detect do |winning_array|
    if winning_array.all?{|index_num| board[index_num] == "X"}
      winning_array.inspect
    elsif winning_array.all?{|index_num| board[index_num] == "O"}
      winning_array.inspect
    end
  end
end

def full?(board)
  board.none?{|i| i == "" || i == " "}
end

def draw?(board)
  won?(board).nil? && full?(board) == true
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    winner = board[won?(board)[0]]
  end
end

##Tie together- play game
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end
