WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board=[" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
 end

def input_to_index(input)
  input=input.to_i
  input=input-1
  return input
end

def move(board,index,token)
  board[index]=token
end

def position_taken?(board,index)
  if board[index]!=" "
    return true
  end
  return false
end

def valid_move?(board,index)
  if board[index]==" " && index>=0 && index <=8
    return true
  end
  return false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  c=0
  board.each{|place|
if place=="X" || place=="O"
  c+=1
end
  }
  return c
end

def current_player(board)
    if turn_count(board)%2==0
    return "X"
  end

  return "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X"
      return win
    end
    if board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O"
      return win
    end
  end
  return false
end

def full?(board)
  if board.none?{|el| el==" "} == true
    return true
  end
end

def draw?(board)
  if full?(board) && won?(board)==false
    return true
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
end

def winner(board)
  if won?(board)!=false
    return board[won?(board)[0]]
  end
  return nil
end
