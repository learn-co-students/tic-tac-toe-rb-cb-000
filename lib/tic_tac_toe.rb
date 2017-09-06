WIN_COMBINATIONS = [
  [0, 1, 2],
  [0, 3, 6],
  [0, 4, 8],
  [3, 4, 5],
  [6, 7, 8],
  [1, 4, 7],
  [2, 5, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
 input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

# code your #valid_move? method here
def valid_move?(board, index)
 !position_taken?(board, index) && index.between?(0,8) ? true : false
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  board[index] == " " || board[index] == "" || board[index] == nil ? false : true
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board,index, player)
    display_board(board)
    true
  else
    turn(board)
  end
end

def turn_count(board)
  number_of_turns = 0
  board.each do |player|
  number_of_turns += 1 if (player == "X" || player == "O")
  end
  return number_of_turns
end


def current_player(board)
  number_of_turns = turn_count(board)
  number_of_turns % 2 == 0 ? "X" : "O"
end

def won?(board)
 WIN_COMBINATIONS.each do |win_combination|
    win_index1 = win_combination[0]
    win_index2 = win_combination[1]
    win_index3 = win_combination[2]

    player_at_position1 = board[win_index1]
    player_at_position2 = board[win_index2]
    player_at_position3 = board[win_index3]

    if (player_at_position1 == "X" && player_at_position2 == "X" && player_at_position3 == "X") || (player_at_position1 == "O" && player_at_position2 == "O" && player_at_position3 == "O")
       return win_combination
     end
  end
  return false
end

def full?(board)
  board.all? do |position|
    position != " "
  end
end

def draw?(board)
  full = full?(board)
  won = won?(board)
  if (!won) && full
    true
  elsif (!won) && (!full) || won
    false
  end
end

def over?(board)
 return true if won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if over?(board)
    win_combination = won?(board)
    win_index = win_combination[0]
    winning_player = board[win_index]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winning_player = winner(board)
    puts "Congratulations " + "#{winning_player}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
