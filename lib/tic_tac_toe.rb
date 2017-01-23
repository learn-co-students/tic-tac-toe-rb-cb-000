# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS= [
top_row = [0,1,2],#top row
   [3,4,5],#middle row
   [6,7,8],#bottow row
   [0,4,8],#diagonal1
   [2,4,6],#diagonal2
   [0,3,6],#line1
   [1,4,7],#line2
   [2,5,8]#line3
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board,input,value)
  board[input]=value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if index.between?(0,8) && ! position_taken?(board,index)
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input= gets.chomp
  index=input_to_index(input)
  if !valid_move?(board,index)
    turn(board)
  end
  move(board,index,current_player(board))
  display_board(board)
end


def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]


    if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
  else
      false
    end
  end
end

def full?(board)
  board.all? do |pos|
    pos == "X" || pos =="O"
  end
end

def draw?(board)
  if !(won?(board)) && full?(board)
    return true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end


def winner(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]


    if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return "X"
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return "O"
  else
      nil
    end
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
