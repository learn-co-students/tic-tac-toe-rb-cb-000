WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [8, 4, 0],
  [6, 4, 2],
  [0, 3, 6],
  [1, 4, 7],
  [8, 5, 2]
]

board = [" "," "," "," "," "," "," "," "," "]


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

def move(board, input_to_index, player_token)
   board[input_to_index] = player_token
end

def position_taken?(board, position)
if board[position] == " " 
  return board[position] != " "
  elsif board[position] == ""
  return board[position] != ""
  elsif board[position] == nil
  return board[position] != nil
  elsif board[position] == "X"
  return board[position] == "X"
  elsif board[position] == "O"
  return board[position] == "O"
end
end

def valid_move?(board, position)
 if !position_taken?(board, position) && position <= 8 && position >= 0
   return true
end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  position = input_to_index(user_input)
  player_token = current_player(board)

    if valid_move?(board, position)
      move(board, position, player_token)
      puts display_board(board)
    else
      puts "Please enter 1-9:"
      turn(board)
      
    end 
end

def turn_count(board)

turns = 0

while turns <= 9

board.each do |position|
  if position == "X" || position == "O"
  turns += 1

end
end
return turns
end
end


def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else return "O"
end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  false
end

def full?(board)
  board.none?{|space| space == " "}
end

def draw?(board)
  if won?(board) == false && full?(board) == true 
    return true
  else false
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
  
WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return "X"
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return "O"
    elsif won?(board) == false
    return nil
    end
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




