def display_board(board)
  puts " "+board[0]+" "+"|"+" "+board[1]+" "+"|"+" "+board[2]+" "
  puts "-----------"
  puts " "+board[3]+" "+"|"+" "+board[4]+" "+"|"+" "+board[5]+" "
  puts "-----------"
  puts " "+board[6]+" "+"|"+" "+board[7]+" "+"|"+" "+board[8]+" "
end


def valid_move?(board,index)
  result = false
  if (index.to_i).between?(0,8) && (board[index] == " " || board[index] == "" || board[index] == nil)
    result = true
  end
  result
end


def move(board, index, token)
  #index = input_to_index(input)
  board[index] = token
end


def input_to_index(input)
  index = (input.to_i)-1
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index, current_player(board))
    display_board(board)

  else
    turn(board)
  end
end

def current_player(board)
  turn = turn_count(board)
  result = (turn % 2 == 0 ? "X" : "O")
  result
end

def turn_count(board)
  turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end
  turns
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diagonal 1
  [2,4,6] # Diagonal 2
  #["X","X","X"],

]

def won?(board)
  WIN_COMBINATIONS.detect do |combos|
    board[combos[0]] ==   board[combos[1]] &&
    board[combos[1]] ==   board[combos[2]] &&
    position_taken?(board, combos[0])
  end
end

def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end

def draw?(board)
 full?(board) && !won?(board)

end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  result = nil
  if won?(board)
    result = won?(board)
    result = board[result[0]]

  end
  result

end



def play(board)
  while !over?(board)
    turn(board)
    draw?(board)
  end

  if won?(board)
    result = winner(board)
    puts "Congratulations #{result}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
