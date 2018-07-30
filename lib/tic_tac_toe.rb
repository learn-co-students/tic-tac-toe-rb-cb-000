

WIN_COMBINATIONS = [
                   [0, 1, 2],
                   [3, 4, 5],
                   [6, 7, 8],
                   [0, 4, 8],
                   [2, 4, 6],
                   [0, 3, 6],
                   [1, 4, 7],
                   [2, 5, 8]
                   ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, position, character)
  board[position] = character
  return board
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index)
    return false
  elsif !(index.between?(0, 8))
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  new_input = input_to_index(input)
  if valid_move?(board, new_input)
    character = current_player(board)
    move(board, new_input, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn != " "
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    character = "X"
  else
    character = "O"
  end
end


def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |wincombo|
    if (board[wincombo[0]]) == "X" && (board[wincombo[1]]) == "X" && (board[wincombo[2]]) == "X"
      return wincombo
    elsif (board[wincombo[0]]) == "O" && (board[wincombo[1]]) == "O" && (board[wincombo[2]]) == "O"
       return wincombo
     end
   end
   false
 end

def full?(board)
  if !(board.include?(" "))
    return true
  else
    return false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    win = won?(board)[0]
    board[win]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
