# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [

  #HORIZONTALS
  [0,1,2],
  [3,4,5],
  [6,7,8],

  #VERTICALS
  [0,3,6],
  [1,4,7],
  [2,5,8],

  #DIAGONALS
  [0,4,8],
  [2,4,6]
]


def won?(board)
  for win_combination in WIN_COMBINATIONS
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    check1 = position_1 == "X" && position_2 == "X" && position_3 == "X"
    check2 = position_1 == "O" && position_2 == "O" && position_3 == "O"

    return win_combination  if check1 == true || check2 == true
  end
  return false
end

def full?(board)
  result = board.detect{|i| i==" "}
  if result == nil
    return true
  else
    return false
  end
end

def draw?(board)
  result = false
  full_board = full?(board)
  won_board = won?(board)
  if full_board && (won_board == false)
    result = true
  end
  return result
end

def over?(board)
  result = false
  result = true if draw?(board)
  result = true if full?(board)
  result = true if won?(board)
  return result
end

def winner(board)
  result = won?(board)
  if result.is_a?(Array)
    result = board[result[0]]
  else
    return nil
  end
  return result
end


def turn_count(board)
  result = 0
  board.each do |spot|
    result +=1 if spot != " "
  end
  return result
end

def current_player(board)
  turn_num = turn_count(board)
  if turn_num % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Helper Methods
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

def move(board, index, cplayer)

  board[index] = cplayer
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
  cplayer = current_player(board)
  if valid_move?(board, index)
    move(board, index, cplayer)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below

def play(board)
  count = 0
  while count < 9 && !over?(board)
    turn(board)
    count += 1
  end
 the_winner = winner(board)
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{the_winner}!"
  end
end
