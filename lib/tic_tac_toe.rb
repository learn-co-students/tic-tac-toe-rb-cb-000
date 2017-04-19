WIN_COMBINATIONS = [
  [3,4,5],
  [0,1,2],
  [6,7,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8]
]

## Primary methods
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    champion = winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end



## Helper Methods
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
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
 arr = board.reject{|i| i == " "}
 arr.count
end

def current_player(board)
# take argument of game board and use turn count to determine next player
  if turn_count(board).even?
    "X"
  elsif turn_count(board).odd?
    "O"
  end
end

def won?(board)
  # for each win combination, get index, load value
  result = nil

  WIN_COMBINATIONS.each do |win_combination|
    #second iteration [3,4,5 ]
    win_index_1 = win_combination[0] #3
    win_index_2  = win_combination[1] #4
    win_index_3 = win_combination[2] #5

    position_1 = board[win_index_1] #board[3] = "X"
    position_2 = board[win_index_2] #board[4] = "X"
    position_3 = board[win_index_3] #board[5] =  "X"

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      result = win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      result = win_combination
    end
    end
    return result
  end

  def full?(board)
    board.none? do |position|
      position == " "
    end
  end

  def draw?(board)
    !won?(board) && full?(board)
  end

  def over?(board)
    won?(board) || full?(board) || draw?(board)
  end

  def winner(board)
    if won?(board)
      champion = won?(board)
      return board[champion[0]]
      #return board[0] # replace 0 with won?board 0
    end
  end
