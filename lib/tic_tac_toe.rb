WIN_COMBINATIONS = [
  [0, 1, 2],  #top_row_win
  [3, 4, 5],   #middle_row_win
  [6, 7, 8],   #botton_row_win
  [0, 3, 6],   #left_column_win
  [1, 4, 7],   #middle_column_win
  [2, 5, 8],   #right_column_win
  [6, 4, 2],   #diagonal_win1
  [0, 4, 8],   #diagonal_win2
]

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
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == position_2 && position_2 == position_3 && position_1 != " "
      return combo
    else false
    end
  end
  false
end


def full?(board)
  !board.include?(" ")
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if over?(board)
    if !draw?(board)
      winning_array = won?(board)
      board[winning_array[0]]
    end
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  end
  if !draw?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
