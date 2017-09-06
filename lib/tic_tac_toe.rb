WIN_COMBINATIONS = [
[0,1,2], #top row
[3,4,5], #middle row
[6,7,8], #bottom row
[0,3,6], #left column
[1,4,7], #middle column
[2,5,8], #right column
[0,4,8], #left diagonal
[2,4,6]] #right diagonal

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
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |ospace|
    if ospace == "X" || ospace == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?(board)
    WIN_COMBINATIONS.each do |winning_combo|
      if (board[winning_combo[0]] == "X" && board[winning_combo[1]] == "X" && board[winning_combo[2]] == "X") ||
        (board[winning_combo[0]]== "O" && board[winning_combo[1]] == "O" && board[winning_combo[2]] == "O")
        return winning_combo
      end
    end
    return false
  end

  def full?(board)
    if board.include?(" ")
      return false
    end
      return true
    end

  def draw?(board)
    if won?(board) == false && full?(board) == true
      return true
    end
      return false
  end

  def over?(board)
    if won?(board) == true || draw?(board) == true || full?(board) == true
      return true
    end
      return false
  end

  def winner(board)
    winning_combo = won?(board)
    if winning_combo == false
      return nil
    elsif board[winning_combo[0]] == "X"
      return "X"
    elsif board[winning_combo[0]] == "O"
      return "O"
  end
  end

def play(board)
  while over?(board) != true && won?(board) == false && draw?(board) != true
    turn(board)
    end
    if winner(board) == "X" || winner(board) == "O"
      puts "Congratulations #{winner(board)}!"
    else
      if draw?(board)
        puts "Cats Game!"
      end
    end
  end
