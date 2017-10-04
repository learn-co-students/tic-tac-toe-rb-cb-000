#Helper methods
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def full?(board)
  if(turn_count(board) == 9)
    return true
  else return false
  end
end

def draw?(board)
  if(full?(board) && !won?(board))
    return true
  else return false
  end
end

def over?(board)
  if(draw?(board) || won?(board))
    return true
  else return false
  end
end

def turn_count(board)
  occupied = 0
  board.each do |x|
    if(x != " ")
      occupied += 1
    end
  end
  return occupied
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    return "X"
  else return "O"
  end
end

def won?(board)
  winArray = []
  if(turn_count(board) == 0)
    return false
  end
  WIN_COMBINATIONS.each do |x|
    if(x.all?{|a| board[a] == "X"})
      return x.to_a
    elsif(x.all?{|a| board[a] == "O"})
      return x.to_a
    end
  end
  return false
end

def winner(board)
  if(won?(board) != false)
    winArray = won?(board)
    return board[winArray[0]]
  else return nil
  end
end

#Win combos
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

@token = "X"
@index = 0

#Main Functions
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

def turn(board)
  @token = current_player(board)
  if valid_move?(board, @index)
    move(board, @index, @token)
    display_board(board)
  else
    play(board)
  end
end

def play(board)
  puts "Please enter 1-9:"
  input = gets.strip
  @index = input_to_index(input)
  if(draw?(board))
    puts "Cat's Game!"
    break
  elsif(won?(board))
    puts "Congratulations #{winner(board)}!"
  end
  move(board, @index, @token)
end
