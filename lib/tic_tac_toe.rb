
WIN_COMBINATIONS = [
  [0, 1, 2], # HORIZONTAL TOP ROW
  [3, 4, 5], # HORIZONTAL MIDDLE ROW
  [6, 7, 8], # HORIZONTAL BOTTOM ROW
  [0, 3, 6], # VERTICAL LEFT ROW
  [1, 4, 7], # VERITCAL MIDDLE ROW
  [2, 5, 8], # VERTICAL RIGHT ROW
  [0, 4, 8], # DIAGONAL LEFT -> RIGHT
  [2, 4, 6]  # DIAGONAL RIGHT -> LEFT
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
  index = input_to_index(gets.strip)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |slot|
    count += 1 if slot == "X" || slot == "O"
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def full?(board)
  board.all? {|f| f == "X" || f == "O"}
end


def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
    index_1 = win_combination[0]
    index_2 = win_combination[1]
    index_3 = win_combination[2]

    position_1 = board[index_1]
    position_2 = board[index_2]
    position_3 = board[index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return false
end

def draw?(board)
   !won?(board) && full?(board)
end

def winner(board)
  win = won?(board)
  win = board[win[0]] if win != false
end

def play(board)
  until over?(board)
    turn(board)
  end
  puts draw?(board) ? "Cats Game!" : "Congratulations #{winner(board)}!"
end
