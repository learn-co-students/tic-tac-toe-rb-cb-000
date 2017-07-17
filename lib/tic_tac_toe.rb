# Helper functions for Tic Tac Toe

#Displays the Tic Tac Toe Board given a board state
def display_board(board)
  first_row = " #{board[0]} | #{board[1]} | #{board[2]} "
  second_row = " #{board[3]} | #{board[4]} | #{board[5]} "
  third_row = " #{board[6]} | #{board[7]} | #{board[8]} "
  row_seperator = "-----------"
  board = "#{first_row}\n"\
          "#{row_seperator}\n"\
          "#{second_row}\n"\
          "#{row_seperator}\n"\
          "#{third_row}"
  puts board
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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

# Determines if the game is won. Takes an board array and returns a boolean
def won?(board)
  WIN_COMBINATIONS.detect do |win|
    board[win[0]] == board[win[1]] && board[win[0]] == board[win[2]] &&
    position_taken?(board, win[0])
  end
end

# Takes a array as an argument and returns true if all positions taken else false
def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

# Takes a board as an argument and returns true for a draw, else false
def draw?(board)
  !won?(board) && full?(board)
end

# Takes a board as an argument and returns true if the game is over else false
def over?(board)
  draw?(board) || won?(board)
end

# Takes a board as an argument and returns the winner as X or O
def winner(board)
  if won = won?(board)
    board[won[0]]
  end
end

# Takes the board state as an argument and determines the current turn number
def turn_count(board)
  turn = 0
  board.each do |position|
    if position == "X" || position == "O"
      turn += 1
    end
  end
  return turn
end

# Takes the board state as an argument and determines the current player
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Returns user input as a valid array index
def input_to_index(input)
  offset = input.to_i - 1
  return offset
end

# Marks players move on the board
def move(board, move, player)
  board[move] = player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Takes the board as argument and runs through a complete turn
def turn(board)
  index = -1
  player = current_player(board)
  until valid_move?(board, index) do
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  move(board, index, player)
  display_board(board)
end

# Takes the board as an argument and runs through a complete game
def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
