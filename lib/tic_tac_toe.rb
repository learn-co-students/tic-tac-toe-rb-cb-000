WIN_COMBINATIONS = [
  [0,1,2], #Top Row
  [3,4,5], #Middle Row
  [6,7,8], #Bottom Row
  [0,4,8], #Diagonal Right
  [2,4,6], #Diagonal Left
  [0,3,6], #Left Column
  [1,4,7], #Right Column
  [2,5,8] #Left Column
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n"
  puts "-----------\n"
  puts " #{board[3]} | #{board[4]} | #{board[5]} \n"
  puts "-----------\n"
  puts " #{board[6]} | #{board[7]} | #{board[8]} \n"
end

def input_to_index(input)
  input = input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
 index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, value = current_player(board))
    display_board(board)
  else
    puts "Please enter 1-9:"
    input = gets.strip
  end
end

def turn_count(board)
  count = 0
  board.each do |i|
    count +=1 if i != " "
  end
  count
end

def current_player(board)
  if !turn_count(board).odd?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && board[combo[2]] == board[combo[0]] && board[combo[0]] != " "
  end
end

def full?(board)
  board.all? {|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)
  status = won?(board)
  if status.nil?
    nil
  else
    board[status[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  elsif over?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
