# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,4,8],
[2,4,6], [0,3,6], [1,4,7], [2,5,8]]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(arrays)
  puts " #{arrays[0]} | #{arrays[1]} | #{arrays[2]} "
  puts "-----------"
  puts " #{arrays[3]} | #{arrays[4]} | #{arrays[5]} "
  puts "-----------"
  puts " #{arrays[6]} | #{arrays[7]} | #{arrays[8]} "
end

def valid_move?(board, index)
  if position_taken?(board, index)
    return false
  elsif !index.between?(0,8)
    return false
  end
  return true
end

# code your input_to_index and move method here!
def input_to_index(input)

  begin
    n = Integer(input)
  rescue ArgumentError
    return -1
  end

  if input.to_i == 0
    return "0".to_i
  end

  return input.to_i - 1
end

def move(board, index, char = "X")
  board[index] = char
  #display_board(board)
  return board
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  converted_input = input_to_index(input)

  until valid_move?(board, converted_input) == true do
    puts "Wrong move. Please pick the right move."
    input = gets.strip
    converted_input = input_to_index(input)
  end

  if turn_count == 0
    move(board, converted_input)
  else
    move(board, converted_input, current_player(board))
  end
  display_board(board)
end

def turn_count(board)
  counter = 0

  board.each do |player|
    if player.strip != ""
      counter += 1
    end
  end

  return counter
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def won?(board)

   match = board.size.times.select{|i| board[i] == "X"}
   match2 = board.size.times.select{|i| board[i] == "O"}

   if !board.include?("X") && !board.include?("O")
     return nil
   end

   WIN_COMBINATIONS.each do |combo|
     if match & combo == combo || match2 & combo == combo
       return combo
     end
   end

   return false
end

def full?(board)
  if(board.size.times.select{|i| board[i] == "X" ||board[i] == "O" }.size == 9)
    return true
  else
    return false
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  elsif !won?(board) && !full?(board)
    return false
  elsif won?(board)
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  end
  return board[won?(board)[0]]
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
