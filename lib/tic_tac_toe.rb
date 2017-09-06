
def display_board(board)

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, index, current_player)
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations " + winner(board) + "!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end

def turn_count(board)
  turns = 0
  for space in board
    if space == "X" || space == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  end
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]
    if position_1 == position_2 && position_1 == position_3 && position_1 != " "
      return win_combination
    end
  end
  return false
end

def full?(board)
  for i in 0..8
    if board[i] == " "
      return false
    end
  end
  return true
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  end
  return false
end

def over?(board)
  if draw?(board) == true
    return true
  end
  if won?(board) != false
    return true
  end
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  else
    return nil
  end
end
