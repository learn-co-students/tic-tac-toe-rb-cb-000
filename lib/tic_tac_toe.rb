board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    true
  else
    false
  end
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end


def play(board)
  turns = 0
  while turns < 9
    turn(board)
    turns += 1
  end
end

def turn_count(board)
  turn = 0
  board.each do |index|
    if index == "X" || index == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  num_turns = turn_count(board)
  if num_turns % 2 == 0
    player = "X"
  else
    player = "O"
  end
  return player
end



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


def won?(board)
  match_array = []
  WIN_COMBINATIONS.each do |index|
    if (board[index[0]] == "X" && board[index[1]] == "X" && board[index[2]] == "X") || (board[index[0]] == "O" && board[index[1]] == "O" && board[index[2]] == "O")
      index.each do |a|
        match_array << a
      end
    end
  end
  if match_array.empty? == true || match_array.nil? == true
    false
  else
    return match_array
  end
end

def full?(board)
  board.all? do |i|
    i == "X" || i == "O"
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
   win = nil
   WIN_COMBINATIONS.each do |index|
     if (board[index[0]] == "X" && board[index[1]] == "X" && board[index[2]] == "X")
       win = "X"
     elsif (board[index[0]] == "O" && board[index[1]] == "O" && board[index[2]] == "O")
       win = "O"
     end
   end
   return win
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  if valid_move?(board, index)
    player_token = current_player(board)
    position_taken?(board, index)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end


def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
