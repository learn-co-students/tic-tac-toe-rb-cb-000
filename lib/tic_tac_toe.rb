board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  num_turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      num_turns += 1
    end
  end
  return num_turns
end

def current_player(board)
  turn_count(board) == 0 || turn_count(board) % 2 == 0 ? "X" : "O"
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index,)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#Define your play method below
def play(board)
  # counter = 0
  while !over?(board)
    turn(board)
    # counter += 1
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end




# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #diagonal left right
  [6,4,2]  #diagonal right left
]

$win_condition = WIN_COMBINATIONS.detect do |win_cond|
  board[win_cond[0]] == board[win_cond[1]]&&
  board[win_cond[0]] == board[win_cond[2]]&&
  position_taken?(board, win_cond[0])
end

def won?(board)
  if board.all? { |i| i == "" || i == " "} == true
    return false
  end

  WIN_COMBINATIONS.detect do |win_cond|
    board[win_cond[0]] == board[win_cond[1]]&&
    board[win_cond[0]] == board[win_cond[2]]&&
    position_taken?(board, win_cond[0])
  end
end


def full?(board)
  if board.detect{|i| i == "" || i == " "}
    return false
  else
    return true
  end
end

def draw?(board)
  !won?(board) && full?(board) ? true : false

end

def over?(board)
  if won?(board) != false && won?(board) != nil || draw?(board) == true
    return true
  else
    return false
  end
end



def winner(board)
  if won?(board) != false && won?(board) != nil
    win = won?(board)
    return board[win[0]]
  else
    return nil
  end
end
