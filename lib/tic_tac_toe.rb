#Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

# displays tic tac toe board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#waiting for user input and converts it to index
def input_to_index(user_input)
  user_input.to_i - 1
end

#places user input onto the board
def move(board, index, current_player)
  board[index] = current_player
  if current_player = "X" || "O"
    return true
  else
    return false
  end
end

#determines if position is taken
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

#determines if move is valid
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#requests user input
def turn(board)
  puts "Please choose a number 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  if valid_move?(board, index)
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end

#determines who the current player is
def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter += 1
      puts "#{counter}"
    end
  end
  counter
end

#Current play turn
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


#defines if there is a winning combination, draw, or if the board is empty
def won?(board)
empty_board = board.all? {|empty| empty == " "}
draw = board.all? {|token| token == "X" || token == "O"}
WIN_COMBINATIONS.any? do |win_combo|
  if win_combo.all? {|index| board[index] =="X" } || win_combo.all? {|index| board[index] =="O"}
     return win_combo
  else empty_board || draw
      false
    end
  end
end

#determines if the board is full
def full?(board)
  board.all? { |space| space == "X" || space == "O"}
end

#determines if there is a draw/nobody win
def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
  end
end

#determines if the game is over by win, draw or full
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end


#determines who the winner is
def winner(board)
  index = []
  index = won?(board)
    if index == false
      return nil
    elsif
      board[index[0]] == "X"
        return "X"
    else
      return "O"
    end
end

#Play method that initiates the loop until game won, full or draw
def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
