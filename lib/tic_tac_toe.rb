board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
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

def move(board, user_input, position)
  board[user_input] = position
end

def position_taken?(board, position)
    if board[position] == " " || board[position] == "" || board[position] == nil
      return false
    else
      return true
    end
end
def valid_move?(board, position)
    if position < 9 && position >= 0 && position_taken?(board, position) == false
      return true
    else
      return false
    end
end
def turn(board)
  puts "Please Enter 1-9"
    position = gets.strip.to_i
    if valid_move?(board , position) == true
      board[position] = current_player(board)
      display_board(board)
    else
      puts "#{position} is already taken."
   turn(board)
  end
end
def turn_count(board)
  counter = 0
  board.each do |value|
    if value == "X" || value == "O"
      counter += 1
    end
  end
  return counter
end
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [2,5,8],
  [1,4,7]
]

def won?(board)
  i = 0
  check = []
  while i < 8
  WIN_COMBINATIONS[i].each do |num|
    check << board[num]
  end
   if check.all?{|x| x == "X"} == true || check.all?{|x| x == "O"} == true
    return WIN_COMBINATIONS[i]
   end
    i += 1
    check = [ ]
  end
end


def full?(board)
    if board.any?{|i| i == " "} == true || board.any?{|i| i == ""} == true
      return false
    else
      return true
    end
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) == true || won?(board) != nil
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != nil
    return board[won?(board)[0]]
  end
end
