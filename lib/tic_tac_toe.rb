WIN_COMBINATIONS=[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(num)
  num = num.to_i
  num = num - 1
  return num
end

def move(board, position, player_token)
  board[position]=player_token
end

def position_taken?(board, index)
  if board[index]==" " || board[index]=="" || board[index]==nil
    return false
  elsif board[index]=="X" || board[index]=="O"
    return true
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    return true
  elsif position_taken?(board, index) || !index.between?(0,8)
    return false
  end
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
  counter=0
  board.each do |index|
    if index=="X" || index=="O"
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board)%2==1
    return "O"
  elsif turn_count(board)%2==0
    return "X"
  end
end

def won?(board)
  xxx=WIN_COMBINATIONS.detect do |combo|
    combo.all? do |index|
      board[index]=="X"
    end
  end
  ooo=WIN_COMBINATIONS.detect do |combo|
    combo.all? do |index|
      board[index]=="O"
    end
  end
  if xxx==nil &&ooo==nil
    return nil
  elsif xxx==nil
    return ooo
  elsif ooo==nil
    return xxx
  end
end

def full?(board)
  if !board.include?(" ")
    return  true
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
  if draw?(board)|| won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    array=won?(board)
    if board[array[0]]=="O"
      return "O"
    elsif board[array[0]]=="X"
      return "X"
    end
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
