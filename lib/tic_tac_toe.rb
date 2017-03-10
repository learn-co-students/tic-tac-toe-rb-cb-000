WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Top-left diagonal
  [6,4,2]  # Bottom-left diagonal
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


def move(board, index, char)
  board[index] = char
  board
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board,index)
  index.between?(0, 8) && !position_taken?(board, index)
end


def turn_count(board)
  count = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      count += 1
    end
  end
  count
end


def current_player(board)
  count = turn_count(board)
  if count.odd? && count != 0
    "O"
  else
    "X"
  end
end


def turn(board)
  player = current_player(board)
  valid = false
  until valid
    puts "Please enter 1-9:"
    user_input = gets
    index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, player)
      display_board(board)
      valid = true
    end
  end
end


def won?(board)
  if board != [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    WIN_COMBINATIONS.select do |combination|
      if combination.all?{|position| board[position] == "X"} || combination.all?{|position| board[position] == "O"}
        return combination.to_a
      end
    end
  nil
  end
end


def full?(board)
  !(board.include?(" ") || board.include?(nil))
end


def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end


def winner(board)
  winning_combo = won?(board)
  if winning_combo
    board[winning_combo[0]]
  end
end


def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
