# Combinations required for a player to win
  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8], #horizontal wins
    [0,3,6], [1,4,7], [2,5,8], #vertical wins
    [0,4,8], [2,4,6] #diagonal wins
  ]

# Establishes the arbitrary format of the game board
  board = [" "," "," "," "," "," "," "," "," "]
  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  # Converts input of user to an Integer
  def input_to_index(user_input)
    user_input.to_i - 1
  end

# Places the users token on the game board
  def move(board, index, player_token)
    board[index] = player_token
  end

  # Checks to see if the position is taken on the board
  def position_taken?(board, index)
    !(board[index] == nil || board[index] == " ")
  end

# Checks to see if the move was valid and not already occupied
  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end


# Determines how many turns have been taken
  def turn_count(board)
    counter = 0
    board.each do |turn|
      if turn == "X" || turn == "O"
        counter += 1
      end
    end
    return counter
  end

# Determines the current_player
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Recieves user input and checks for validity/places user token
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
    if valid_move?(board, index) == true
      move(board, index, current_player(board))
      display_board(board)
    else
      puts "That entry is invalid"
      turn(board)
    end
end

#Test to see if there is a winning combination on the board
def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] && board[win_combo[0]] == board[win_combo[2]] && position_taken?(board, win_combo[1])
end
end

#Test to see if the game board is full
def full?(board)
  board.none?{|i| i == " " || i == ""}
end

#Test to see if the game has ended in a Draw
def draw?(board)
  !won?(board) && full?(board) == true
end

#Test to see if the game is over
def over?(board)
  draw?(board) == true || won?(board) != nil
end

#Test to determine which token is the winner
def winner(board)
  if winner = won?(board)
    board[winner.first]
  end
end

# Starts the game
def play(board)
  until over?(board) == true
    turn(board)
  end
  if draw?(board) == true
    puts "Cats Game!"
  else won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
