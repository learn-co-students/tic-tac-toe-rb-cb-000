WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[2,5,8],[1,4,7],[0,4,8],[6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  if user_input.to_i != nil
    index = user_input.to_i
    index = index-1
    return index
  else
    index = -1
    return index
  end
end


def turn_count(board)
  counter=0
board.each do |index|
  if index == "X" || index == "O"
    counter +=1
  end
 end
 return counter
end



def position_taken?(board,index)
  if board[index] == "X" || board[index] == "O"
    return true
  else
    return false
  end
end

def move(board,position,player)
  if player == 'X' || player == 'O'
    board[position]=player
  end
end

def valid_move?(board,index)
  index_10=index
  if index_10.between?(0,8) == true && position_taken?(board,index) == false
    return true
  else
    return false
  end
end




def turn(board)
  a=-1
  until valid_move?(board,a) == true
  print "Please enter 1-9:"
  user_input = gets.strip
  a=input_to_index(user_input)
  end
   move(board,a,current_player(board))
   display_board(board)
 end




def full?(board)
  counter=0
  board.each do |index|
    if index == "X" || index == "O"
      counter +=1
   end
 end
   if counter == 9
     return true
   else
     return false
 end
end

def current_player(board)
  if turn_count(board).even? == true
    return "X"
  else
    return "O"
  end
end



def won?(board)
  counter = 0
  WIN_COMBINATIONS.each do |index|
    index_1 = index[0]
    index_2 = index[1]
    index_3 = index[2]

    if board[index_1] == "X" && board[index_2] == "X"  && board[index_3] == "X"
      counter = counter + 1
      return true
    elsif board[index_1] == "O" && board[index_2] == "O"  && board[index_3] == "O"
      counter = counter + 1
      return true
    end
  end
if counter == 0 && full?(board) == true
  return false
 end
end



def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
 end
end


def over?(board)
if full?(board) == false && won?(board) == false
  return false
elsif full?(board) == true || won?(board) == true || draw?(board) == true
  return true
end
end

def winner(board)
  counter = 0
  WIN_COMBINATIONS.each do |index|
    index_1 = index[0]
    index_2 = index[1]
    index_3 = index[2]
    if board[index_1] == "X" && board[index_2] == "X"  && board[index_3] == "X"
      counter = counter + 1
      return "X"
    elsif board[index_1] == "O" && board[index_2] == "O"  && board[index_3] == "O"
      counter = counter + 1
      return "O"
    end
  end
  if counter == 0
    return nil
  end
end


def play(board)
  until over?(board) == true
  turn(board)
  end
  if winner(board) == "X"
  puts "Congratulations X!"
elsif winner(board) == "O"
  puts "Congratulations O!"
elsif winner(board) == nil
  puts "Cat's Game!"
  end
end
