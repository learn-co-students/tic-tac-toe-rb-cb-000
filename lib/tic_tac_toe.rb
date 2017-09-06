
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



def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
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




def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end



def valid_move?(board, index)
  if index.between?(0, 8) == true && position_taken?(board, index) == false
  true
  end
end



def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end



def input_to_index(input)
  input.to_i - 1
end



def move(board, index, value)
  board[index] = value
board
end



def won?(board)
  WIN_COMBINATIONS.each do |winindex|
    if board[winindex[0]] == "X" && board[winindex[1]] == "X" && board[winindex[2]] == "X"
      return winindex
    elsif board[winindex[0]] == "O" && board[winindex[1]] == "O" && board[winindex[2]] == "O"
      return winindex
    end
  end
  return false
end



def full?(board)
   board.none? { |e| e == " " }
end



def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  end
end



def over?(board)
  if won?(board) == true || draw?(board) == true || full?(board) == true
    true
  end
end



def winner(board)
  winindex = won?(board)
  if winindex == false
    return nil
  elsif board[winindex[0]] == "X"
    return "X"
  elsif board[winindex[0]] == "O"
    return "O"
  end
end



# def turn(board)
#   puts "Please enter 1-9:"
#   input = gets.strip
#   index = input_to_index(input)
#   until valid_move?(board, index) == true
#     puts "Please enter 1-9:"
#     input = gets.strip
#     index = input_to_index(input)
#   end
#   move(board, index, value = "X")
#   display_board(board)
# end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  until valid_move?(board, index) == true
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  move(board, index, value = current_player(board))
  display_board(board)
end



def play(board)
  until over?(board) == true || won?(board) != false
    turn(board)
  end
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    elsif draw?(board) == true
      puts "Cats Game!"
    end
end
