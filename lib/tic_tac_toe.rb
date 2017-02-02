
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

def move(board, index, current_player)
  board[index] = current_player
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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

#def turn_count(board)
#  plays = board.select{|i| i!=" "}
#  return plays.length
#end

# Define your play method below
def play(board)
  #curr_board = board
  until (over?(board)) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
  #current_board = board
  #turn = 0
  #while turn < 9
    #turn(current_board)
    #turn += 1
    #if won?(current_board)
      #puts "Congratulations #{winner(current_board)}"
    #elsif draw?(current_board)
    #  puts "Cats Game!"
    #end
  #end

end

def turn_count(board)
  turns = 0
  board.each do |player|
    if player == "X" or player == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turns = turn_count(board)
  return turns % 2 == 0 ? "X":"O"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]
    win_val1 = board[win_index_1]
    win_val2 = board[win_index_2]
    win_val3 = board[win_index_3]
    if win_val1 == win_val2 && win_val2 == win_val3 && position_taken?(board,win_index_1)
      return combo
    end
  end
  return false
end

def full?(board)
  board.detect{|val| val == " "} ? false : true
end

def draw?(board)
  won?(board) ? false :full?(board)
end

def over?(board)
  (won?(board) || draw?(board)) ? true : false
end

def winner(board)
  puts board
  won?(board) ? board[won?(board)[0]] : nil
end
