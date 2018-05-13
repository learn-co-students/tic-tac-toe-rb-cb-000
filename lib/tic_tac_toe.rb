

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  o = WIN_COMBINATIONS.detect { |e| e.all? { |e| board[e] == "O"} }
  x = WIN_COMBINATIONS.detect { |e| e.all? { |e| board[e] == "X"} }
  if(x == nil && o == nil)
    return false
  end
  o == nil ? x : o
end


def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end


def full?(board)
  [0,1,2,3,4,5,6,7,8].all? { |e| position_taken?(board, e) }
end


def turn_count(board)
  cells = [0,1,2,3,4,5,6,7,8].select { |e| board[e] != " " }
  cells.length
end


def draw?(board)
  if (full?(board) && !won?(board))
    return true
  end
end


def over?(board)
  return draw?(board) || won?(board) ? true : false
end

def winner(board)
  if(won?(board) == false)
    return nil
  end
  return board[won?(board)[0]] == "X" ? "X" : "O"
end

# Define your WIN_COMBINATIONS constant
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
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  x = input.to_i
  return (x.is_a? Integer) ? (x - 1) : -1
end

def move(board, position, token)
  board[position] = token
end

def valid_move?(board, position)
  if(position == -1 || board[position] != " ")
    return false
  else
    true
  end
end

def turn(board)
  flag = false
  while (flag == false) do
    puts "Please select cell 1 to 9:"
    move = gets.strip
    index = input_to_index(move)
    flag = valid_move?(board, index)
  end
  move(board, index, current_player(board))
end


# def play(board)
#   display_board(board)
#   flag = false
#   while (flag == false) do
#     turn(board)
#     display_board(board)
#     flag = over?(board)
#   end
#   puts winner(board) != nil ? "Congratulations #{winner(board)}!" : "Cat's Game!"
# end


def play(board)
  # display_board(board)
  while (!over?(board)) do
    turn(board)
  #   display_board(board)
    won?(board)
  end
  puts winner(board) != nil ? "Congratulations #{winner(board)}!" : "Cat's Game!"
end
