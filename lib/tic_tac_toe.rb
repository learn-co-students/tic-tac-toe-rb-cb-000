WIN_COMBINATIONS = [
  [0,1,2], # Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Left to Right Diagonal
  [2,4,6]  # Right to Left Diagonal
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

def turn_count(board)
  counter = 0
  board.each do |position|
    if position != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).to_i.even?
    current_player = "X"
  else
    current_player = "O"
  end
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if board[index] == " "
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, index)
  if (!position_taken?(board, index) && index.between?(0,8))
    true
  else
    false
  end
end

def turn(board)
  puts "Place your token by entering a number from 1-9 (inclusive):"
    index = input_to_index(gets.chomp)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
      if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X") ||
        (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
        return win_combo
      end
  end
  return false
end

def full?(board)
  if board.include?(" ")
    return false
  else
    return true
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if (won?(board) == true) || (draw?(board) == true) || (full?(board) == true)
    return true
  end
  return false
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  end
  return nil
end
