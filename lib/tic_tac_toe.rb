WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]
  


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

def move(board, input_to_index, char)
  board[input_to_index] = char
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true 
  else
    board[index] == " " || ""
    return false 
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index <= 8 && index >= 0
    return true
  end
end

def turn(board)
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board,index)
      puts "Please enter 1-9:"
    turn(board)
  end
  move(board, index, current_player(board))
end

def turn_count(board)
    counter = 0
    board.each do |box|
      if ["X", "O"].include?box.strip
        counter +=1
      end
    end
    counter
end

def current_player(board)
  if turn_count(board).odd?
    return "O"
  else 
    return "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]
     
    if (board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X") || (board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O")
       return combo
    end
  end
end

def full?(board)
  board.all? do |index|
  index == "X" || index == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else won?(board) == true
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else 
    return false
  end
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board) 

  until over?(board)
    puts "Please enter 1-9:"
    turn(board)
 end
 
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end

end

