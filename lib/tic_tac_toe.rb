# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#  WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts"-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts"-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# input_to_index , This method takes the user_input (which is a string), converts it to an Integer, and subtracts 1
def input_to_index(num)
  return num.to_i - 1
end

#move accepts board,index and player's character. places the  player's character at provided index
def move(board,index,token)
 return board[index] = token
end

#valid_move method accepts a board and an index to check and returns true if the move is valid
def valid_move?(board,index)
  if index < 9 && index > -1 && board[index] != 'X' && board[index] != 'O'
    return true
  else
    return false
  end
end

=begin turn method accepts board as argument
Convert user input to an index
If the move is valid, make the move and display board.
Otherwise ask for a new position until a valid move is received.
=end
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  is_valid = valid_move?(board,index)
  if is_valid === true
    current_turn = current_player(board)
    move(board,index,current_turn)
    display_board(board)
  else
    puts 'Please enter correct input'
    puts "Please enter 1-9:"
    input = gets.strip
  end
end

#This method takes in an argument of the board array and returns the number of turns that have been played
def turn_count(board)
  count  = 0
  board.each do |player|
    if player == 'X' || player == 'O'
      count += 1
    end
  end
  return count
end

# determine if turn is "X"'s turn or "O"'s.
def current_player(board)
  turn = turn_count(board)
  if turn%2 == 0
    return "X"
  else
    return 'O'
  end
end

=begin this method should accept a board as an argument and return false/nil if there is no win combination
       present in the board and return the winning combination indexes as an array if there is a win
=end
def won?(board)
  if board.all?{|position|position == " "}
    return false
  end
  no_combinations = true
  WIN_COMBINATIONS.each do |combination|
    if combination1 = board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X" ||
       combination2 = board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
        no_combinations = false
        return combination
    end
  end
  if no_combinations == true
    return false
  end
end

#full method should accept a board and return true if every element in the board contains either an "X" or an "O".
def full?(board)
  any_spaces =  board.any?{|element| element == " "}
    if any_spaces == true
      return false
    else
      return true
    end
end

#accepts a board and returns true if the board has not been won and is full and false if the board is not won and the board is not full, and false if the board is won
def draw?(board)
  incomplete_board = !full?(board)
  is_game_won = won?(board)
    if incomplete_board == true
      return false
    elsif is_game_won.is_a?(Array)
      return false
    else
      return true
    end
end

#over? accepts a board and returns true if the board has been won, is a draw, or is full.
def over?(board)
  WIN_COMBINATIONS.each do |combination|
    if combination1 = board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X" ||
       combination2 = board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
        return true
    end
  end
  draw = full?(board)
    if draw == true
      return true
    else
      return false
    end
end

#winner method should accept a board and return the token, "X" or "O" that has won the game given a winning board
def winner(board)
  no_combinations = true
  WIN_COMBINATIONS.each do |combination|
    if combination1 = board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
        no_combinations = false
        return "X"
    elsif combination2 = board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
            no_combinations = false
            return "O"
    end
  end
  if no_combinations == true
   return nil
  end
end

=begin
The play method is the main method of the tic tac toe application and is responsible for the game loop. A tic tac toe game must allow players to take turns,
checking if the game is over after every turn, and at the conclusion of the game, whether because it was won or because it was a draw,
reporting to the user the outcome of the game
=end
def play(board)
  board.each do|turn|
    is_game_over = over?(board)
    is_game_won = won?(board)
    is_game_draw = draw?(board)
    if is_game_over == true
      if is_game_won.is_a?(Array)
        winner = winner(board)
        puts "Congratulations #{winner}!"
        return " "
      elsif is_game_draw == true
        puts "Cat\'s Game!"
        return " "
      else
        return false
      end
    else
      if is_game_won.is_a?(Array)
        winner = winner(board)
        puts "Congratulations #{winner}!"
        return " "
      elsif is_game_draw == true
        puts "Cat\'s Game!"
        return " "
      else
        turn(board)
      end
    end
  end
end
