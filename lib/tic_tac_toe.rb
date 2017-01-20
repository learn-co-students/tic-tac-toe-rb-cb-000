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

def move(board, index, token)
  board[index] = token
  display_board(board)
end

def position_taken?(board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  player_choice = gets.strip
  index = input_to_index(player_choice)

  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0

  board.each do |spot|
    if spot == "X" || spot == "O"
      counter += 1
    end
  end

  counter
end

def current_player(board)
  counter = turn_count(board)
  counter.even? ? "X" : "O"
end

def won?(board)
  winning_combo = []

  WIN_COMBINATIONS.each do |win_combination|
    x_winner = win_combination.all? do |position|
      board[position] == "X"
    end

    o_winner = win_combination.all? do |position|
      board[position] == "O"
    end

    if x_winner || o_winner
      winning_combo = win_combination
    end
  end

  if winning_combo != []
    winning_combo
  else
    false
  end
end

def full?(board)
  board.all? { |position| position == "X" || position == "O" }
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    position = won?(board)[0]
    board[position]
  else
    nil
  end
end

def play(board)
  while not over?(board)
    turn(board)
  end

  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
