WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

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

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, position)
  board[position] == "X" || board[position] == "O"
end

def valid_move?(board, position)
  board[position] == " " && position.between?(0, 8)
end

def turn(board)
  player = current_player(board)
  while true
    puts "Please enter 1-9:"
    user_input = gets.chomp
    position = input_to_index(user_input)
    if valid_move?(board, position)
      move(board, position, player)
      display_board(board)
      break
    end
  end
end

def turn_count(board)
  count = 0
  board.each do |char|
    if char != " "
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_array|
    if ((board[win_array[0]] == board[win_array[1]]) && (board[win_array[0]] == board[win_array[2]])) && board[win_array[0]] != " " && board[win_array[0]] != ""
      return true
    end
  end
  if full?(board)
      return false
  end
  return false
end

def full?(board)
  board.all? { |char| char == "X" || char == "O"}
end

def draw?(board)
  full?(board) && won?(board) == false
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board) == false
    return nil
  else
    count_x = 0
    count_o = 0
    board.each do |char|
      if char == "X"
        count_x += 1
      elsif char == "O"
        count_o += 1
      end
    end
    count_x > count_o ? "X" : "O"
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
