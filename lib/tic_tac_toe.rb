# Helper Method
WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # Left row
  [1, 4, 7], # Middle row
  [2, 5, 8], # Right row
  [0, 4, 8], # Diagonal 1
  [2, 4, 6], # Diagonal 2
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


def move(board, index, current_player = "X")
  board[index] = current_player
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  count
end


def current_player(board)
  turn_count(board).even? ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
      board[win_combo[0]] == board[win_combo[1]] &&
      board[win_combo[1]] == board[win_combo[2]] &&
      position_taken?(board, win_combo[0])
  end
end


def full?(board)
  board.all? do |token|
  token == "X" || token == "O"
  end
end


def draw?(board)
  full?(board) && !won?(board)
end


def over?(board)
  won?(board) || draw?(board) || draw?(board)
end


def winner(board)
  if winner = won?(board)
    board[winner.first]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
end
