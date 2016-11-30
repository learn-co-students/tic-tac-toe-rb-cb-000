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

def display_board(args)
  puts " #{args[0]} | #{args[1]} | #{args[2]} "
  puts "-----------"
  puts " #{args[3]} | #{args[4]} | #{args[5]} "
  puts "-----------"
  puts " #{args[6]} | #{args[7]} | #{args[8]} "
end

def input_to_index(x)
  a=x.to_i
  a=a-1
end

def move(arr, indx, ltr)
  arr[indx]=ltr
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && !(position_taken?(board,index))
    true
  else
    false
  end

end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  a = input_to_index(index)
  if !valid_move?(board, a)
    turn(board)
  end
  move(board, a, current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |a|
    if !(a == "" || a == nil || a == " ")
      counter += 1
    end
  end
  counter
end

def current_player(board)
  a = turn_count(board)

  b = a % 2 == 0 ? "X" : "O"

  b
end

def won?(board)
  if (board.all? {|i| i == "" || i ==" "})
    false
  else
    WIN_COMBINATIONS.detect do |x|
      (board[x[0]] == "X" && board[x[1]] == "X" && board[x[2]] == "X") || (board[x[0]] == "O" && board[x[1]] == "O" && board[x[2]] == "O")
    end
  end

end

def full?(board)
  board.all? do |code|
    (code == "X" || code == "O")
  end
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
   a = won?(board)
   board[a[0]]
 end
end

def play(board)
  while !(over?(board))
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
