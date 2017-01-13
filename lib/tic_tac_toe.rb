require 'pry'
WIN_COMBINATIONS = [
  [0,1,2], #horizontal
  [3,4,5],
  [6,7,8],

  [0,3,6], #vertical
  [1,4,7],
  [2,5,8],

  [0,4,8], #diagonal
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} " #beware of spacing. Rspec is specific
  puts "------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1 #convert input to integer and subtract 1.
                #users count from 1
                #ruby counts from 0
end

def move(board, position, player)
  board[position] = player   #ex. board[2] = "X"
end

def position_taken?(board, position)
  board[position] != " " #if this point on the board is not blank. Position must be taken
end

def valid_move?(board, position)
  !position_taken?(board,position) && position.to_i.between?(0,8)
  #if the position isnt taken and is on the board, move must be valid
end

def turn(board)
  puts "Please enter a number 1-9"
  input = input_to_index(gets.strip) #convert user input. See input_to_index method
  if valid_move?(board, input)
    move(board,input, current_player(board)) #if move is valid, make a move
  else
    turn(board) #if move isnt valid, try again. Call this method again
  end
  display_board(board)
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def turn_count(board)
   board.count{|space| space != " "} #counts all spaces that are not blank.
                            #for every space that is not blank, a turn has been played
end

def won?(board)

  WIN_COMBINATIONS.detect do |combination| #checking every combination in win_combinations
  board[combination[0]] != " " && (board[combination[0]] == board[combination[1]] &&
    board[combination[2]] == board[combination[1]]) # if the 3 indexes match, its a winner
  end
  #this method returns the winning array. Detect returns an array.
  #returns nil if no winner
end

def full?(board)
  board.all?{|pos| pos != " "} #true if all elements are not blank.
end

def draw?(board)
  !won?(board) && full?(board) #true if no winner and board is full
end

def over?(board)
  draw?(board) || won?(board) #true if draw or won
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
  #if there is a winner, return the player character otherwise nil.
  #remember won? returns an array if detected. won?(board[0]) is either X or O
end

def play(board)
  while !over?(board) #if the game isnt over, play another turn
    turn(board)
  end

  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  end

  if draw?(board)
    puts "Cats Game!"
  end
end
