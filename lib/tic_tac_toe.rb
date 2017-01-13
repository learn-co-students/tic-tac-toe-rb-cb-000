# Define your WIN_COMBINATIONS constant
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
  index = input_to_index(gets.strip)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0

  board.each do |slot|
    count += 1 if slot == "X" || slot == "O"
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

#Method to determine if there is a winning combo on the board
def won?(board)
  WIN_COMBINATIONS.each do |c|
    if c.all?{|pos| board[pos]=="X"} || c.all?{|pos| board[pos]=="O"}
      return c
    else
      false
    end
  end
  false #If win combo not found return false
end

#To determine if the board is full
def full?(board)
  board.all? {|pos| pos == "X" || pos == "O"}
end

#Determine if there is a draw on the board (fill & no winner)
def draw?(board)
  !won?(board) && full?(board)
end

#over? accepts a board and returns true if the board has been won, is a draw, or is full.
def over?(board)
  full?(board) || won?(board) || draw?(board)
end

#winner method should accept a board and return the token, "X" or "O"
def winner(board)
  win = won?(board)
  win = board[win[0]] if win != false
end

#The main play loop for the game
def play(board)
  until over?(board)
    turn(board)
  end
  puts draw?(board) ? "Cats Game!" : "Congratulations #{winner(board)}!"
end
