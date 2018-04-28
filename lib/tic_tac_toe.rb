#Define the winning combinations
WIN_COMBINATIONS = [[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[2,4,6]
  ]
  
#display board
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
  if valid_move?(board, index)
    current_player = current_player(board)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position != " "
      count += 1
    end
  end
  return count
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0 || count == 0
    return "X"
  else 
    return "O"
  end
end

def won?(board)
  win_combo = []
  WIN_COMBINATIONS.each do |combination|
    x_count = []
    o_count = []
    combination.each do |index|
      case board[index]
      when "X"
        x_count.push(index)
      when "O"
        o_count.push(index)
      end
    end
    if x_count.length == 3
      return win_combo = x_count
    elsif o_count.length == 3
      return win_combo = o_count
    end
  end
  if win_combo != []
    return win_combo
  else
    return false
  end
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true || full?(board) == true
    return true
  end
end

def winner(board)
  win = " "
  if won?(board) != false
     won?(board).each do |index|
      win = board[index]
    end
  else win = nil
  end
  return win
end

def play(board)
  while over?(board) != true
      turn(board)
  end
  if draw?(board) == true
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end