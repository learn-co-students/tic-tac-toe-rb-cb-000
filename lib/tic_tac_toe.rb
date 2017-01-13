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
    userInput = gets.strip
    index = input_to_index(userInput)
    if valid_move?(board, index)
      move(board, index, current_player(board))
    else
      puts "That is an invalid move, try again!"
      turn(board)
    end
    display_board(board)
end

def turn_count(board)
 count = 0
 board.each do |space|
   if space != " "
     count += 1
   end
 end
   count
end

def current_player(board)
  player_X = "X"
  player_O = "O"
  if turn_count(board) % 2 == 0
    player_X
  else
    player_O
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    (board[win_combination[0]] != " ") && (board[win_combination[0]] == board[win_combination[1]] && board[win_combination[2]] ==
   board[win_combination[1]])
  end
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    win_array = won?(board)
    board[win_array[0]]
  elsif draw?(board)
    nil
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
