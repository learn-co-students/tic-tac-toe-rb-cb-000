
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

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end


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

def move(board, position, token)
 board[position] = token
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  elsif board[index] == " " || "" || nil
    return false
  end
end

def valid_move?(board, index)
  if position_taken?(board, index)
    return false
  end
  if index.between?(0, 8)
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  i_to_i = input_to_index(user_input)
  if valid_move?(board, i_to_i)
    puts "valid move"
    if turn_count(board).even?
      token = "X"
    else
      token = "O"
    end
    move(board, i_to_i, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |move|
    if move == "X" || move == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
      return win_combination
      elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
        return win_combination
      end
    end
    return false
end

def full?(board)
  board.all? { |player| player == "X" || player == "O" }
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  end
end

def over?(board)
  if draw?(board)
    return true
  elsif won?(board)
    return true
  elsif full?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    xcount = board.count("X")
    ocount = board.count("O")
    if xcount > ocount
      return "X"
    elsif ocount > xcount
      return "O"
    end
  end
end
