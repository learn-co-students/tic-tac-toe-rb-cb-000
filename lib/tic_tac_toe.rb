
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6],[1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def input_to_index(user_input)
user_input = user_input.to_i
user_input = user_input - 1
end

def move(board, position, char)
  board[position] = char
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  else return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && position_taken?(board, index) == false
    return true
  else return false
  end
end



def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  input_to_index_var = input_to_index(input)
  if valid_move?(board, input_to_index_var)
    move(board, input_to_index_var, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def won?(board)

  counterX = 0
  counterO = 0

  WIN_COMBINATIONS.each do |win|
    counterX = 0
    counterO = 0
   win.each do |position|
      if board[position] == "X"
        counterX += 1
      end
      if board[position] == "O"
        counterO += 1
      end
      if counterX == 3 || counterO == 3
        return win
      end
   end
  end
  return false
end

def full?(board)
  board.each do |position|
   if position != "O" && position != "X"
    return false
   end
  end
  return true
end

def draw?(board)
   if !won?(board) && full?(board)
       return true
   end
   return false
  
end


def over?(board)
 if won?(board) || full?(board) || draw?(board)
   return true
 end
end


def winner(board)
  if won?(board)
     won?(board).each do |pos|
       if board[pos] == "X"
         return "X"
      end
      if board[pos] == "O"
        return "O"
      end
    end
  end
end

def turn_count(board)
  counter = 0
  board.each do |plays|
    if (plays == "X" || plays == "O")
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

def play(board)
until over?(board)
  turn(board)
end

if won?(board)
  puts "Congratulations #{winner(board)}!"
else 
  puts "Cats Game!"
end

end




