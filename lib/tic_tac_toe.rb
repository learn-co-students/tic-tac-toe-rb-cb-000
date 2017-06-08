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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  board[position] == "" || board[position] == " " ? false : true
end

def valid_move?(board, position)
  !position_taken?(board, position) && index_valid?(position)
end

def index_valid?(position)
  position.between?(0, 8)
end


def turn(board)
  puts "Please enter input: 1 - 9"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  if index_valid?(index)
    move(board, index, token)
  else
    puts "Invalid input, please try again!"
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |tile|
    if tile == "X" || tile == "O"
      counter += 1
    else
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.any? do |win_combination|
    return_array = []
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_index_1 = board[win_index_1]
    position_index_2 = board[win_index_2]
    position_index_3 = board[win_index_3]

    if (position_index_1 == "X" && position_index_2 == "X" && position_index_3 == "X")
      return_array = [win_index_1, win_index_2, win_index_3]
      return return_array
    elsif (position_index_1 == "O" && position_index_2 == "O" && position_index_3 == "O")
      return_array = [win_index_1, win_index_2, win_index_3]
      return return_array
    else
      false
    end
  end
end
def full?(board)
  board.all? { |x| x == "X" || x == "O" }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  token = won?(board)
  token ? board[token[0]] : nil
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  else
  end
end
