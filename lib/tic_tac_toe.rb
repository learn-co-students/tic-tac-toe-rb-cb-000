# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Left-to-right diagonal
  [2,4,6]  # Right-to-left diagonal
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

def move(board, index, player_token)
  board[index] = player_token
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  count = 0
  board.each do | token |
    if token == "X" || token == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  # use the return value from #turn_count to modulo return "X" or "O"
  #player_token = ""
  count = turn_count(board)
  count.even? ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  if won_empty?(board)
    false
  elsif draw_first_row(board)
    false
  else
    determine_win(board)
  end
end

def won_empty?(board)
  board.all? do | token |
    token == " "
  end
end

def won_draw?(board)
  board.none? do | token |
    token == " "
  end
end

def determine_win(board)
  result = []
  WIN_COMBINATIONS.each do | combination |
    combination.each do | token |
      if position_taken?(board, token)
        result << token
      end
      if result.length == 3
        return result
      end
    end
  end
end

def full?(board)
  board.all? do | token |
    token == "X" || token == "O"
  end
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  end
end

def draw_false?(board)
  return true if (draw_first_row(board) && board.none?{|token| token == " "})
end

def draw_first_row(board)
  if (board[0] == "X" && board[1] == "X" && board[2] == "X") || (board[0] == "O" && board[1] == "O" && board[2] == "O")
    return false
  elsif (board[3] == "X" && board[4] == "X" && board[5] == "X") || (board[3] == "O" && board[4] == "O" && board[5] == "O")
    return false
  elsif (board[6] == "X" && board[7] == "X" && board[8] == "X") || (board[6] == "O" && board[7] == "O" && board[8] == "O")
    return false
  elsif (board[0] == "X" && board[3] == "X" && board[6] == "X") || (board[0] == "O" && board[3] == "O" && board[6] == "O")
    return false
  elsif (board[1] == "X" && board[4] == "X" && board[7] == "X") || (board[1] == "O" && board[4] == "O" && board[7] == "O")
    return false
  elsif (board[2] == "X" && board[5] == "X" && board[8] == "X") || (board[2] == "O" && board[5] == "O" && board[8] == "O")
    return false
  elsif (board[0] == "X" && board[4] == "X" && board[8] == "X") || (board[0] == "O" && board[4] == "O" && board[8] == "O")
    return false
  elsif (board[2] == "X" && board[4] == "X" && board[6] == "X") || (board[2] == "O" && board[4] == "O" && board[6] == "O")
    return false
  else
    return true
  end
end

def over?(board)
  if draw_false?(board)
    true
  elsif !draw_first_row(board)
    true
  else
    false
  end
end

def winner(board)
  if (board[0] == "X" && board[1] == "X" && board[2] == "X") ||
     (board[3] == "X" && board[4] == "X" && board[5] == "X") ||
     (board[6] == "X" && board[7] == "X" && board[8] == "X") ||
     (board[0] == "X" && board[3] == "X" && board[6] == "X") ||
     (board[1] == "X" && board[4] == "X" && board[7] == "X") ||
     (board[2] == "X" && board[5] == "X" && board[8] == "X") ||
     (board[0] == "X" && board[4] == "X" && board[8] == "X") ||
     (board[2] == "X" && board[4] == "X" && board[6] == "X")
     return "X"
  elsif (board[0] == "O" && board[1] == "O" && board[2] == "O") ||
        (board[3] == "O" && board[4] == "O" && board[5] == "O") ||
        (board[6] == "O" && board[7] == "O" && board[8] == "O") ||
        (board[0] == "O" && board[3] == "O" && board[6] == "O") ||
        (board[1] == "O" && board[4] == "O" && board[7] == "O") ||
        (board[2] == "O" && board[5] == "O" && board[8] == "O") ||
        (board[0] == "O" && board[4] == "O" && board[8] == "O") ||
        (board[2] == "O" && board[4] == "O" && board[6] == "O")
        return "O"
  end
end

# Define your play method below
def play(board)
  round = 0
  while (round < 9 && over?(board) == false && !won?(board) && !draw?(board)) do
    turn(board)
    round += 1
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    #winner(board)
  elsif draw?(board)
    puts "Cats Game!"
  end
end
