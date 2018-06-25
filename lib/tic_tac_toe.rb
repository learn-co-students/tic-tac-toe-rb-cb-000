WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6]
]

def display_board(board)
    puts " #{board[0]} " + "|"+ " #{board[1]} " + "|"+  + " #{board[2]} "
    puts "-----------"
    puts " #{board[3]} " + "|"+ " #{board[4]} " + "|"+  + " #{board[5]} "
    puts "-----------"
    puts " #{board[6]} " + "|"+ " #{board[7]} " + "|"+  + " #{board[8]} "
end

def input_to_index(input)
  index = (input.to_i) - 1
  return index
end

def valid_move?(board, index)
  if (index.between?(0,8))
    if (position_taken?(board, index) == false)
      return true
    end
  end
end


def position_taken?(board, index)
  if (board[index] == "" || board[index] == " " || board[index] == nil)
    return false
  else
    return true
end
end

def move(board, input, letter)
  board[input] = letter
end

def turn(board)
  puts "Please enter 1-9:"
  input = input_to_index(gets.strip)
  if valid_move?(board, input) == true
    if turn_count(board) % 2 == 0
      letter = "X"
      move(board, input, letter)
      display_board(board)
    else
      letter = "O"
      move(board, input, letter)
      display_board(board)
    end
  else
  puts "Invalid Entry"
  turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |item|
  puts {item}
   if (item != " ")
   counter += 1
    end
  end
  return counter
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win|
    if win.all?{|index_num| board[index_num] == "X"}
      win.inspect
    elsif win.all?{|index_num| board[index_num] == "O"}
      win.inspect
    end
  end
end

def full?(board)
  board.none? {|space| space == " " || space == nil}
end

def draw?(board)
  won?(board).nil? && full?(board)
end

def over?(board)
  #Game is over if the game is won OR if the game is a draw
  #Returns False is game is not full and is not won or a draw
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if (over?(board) && won?(board))
    #Returns the value of array "Board" where win condition was met
    return board[won?(board)[0]]
  end
end

def play(board)
  while (turn_count(board) <= 9) && !over?(board)
  turn(board)
  end
  winner(board)
  if (winner(board) == "X" || winner(board) == "O")
  puts "Congratulations " +winner(board) + "!"
else
  puts "Cat's Game!"
end
end
