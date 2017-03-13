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

# Display the current state of the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Change user input into array index (starts at 0 instead of 1)
def input_to_index(input)
  input.to_i - 1
end

# Check if a position is already filled
def position_taken?(board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

# Check if position is available and number is between 0 and 8 (for array)
def valid_move?(board, index)
  if (!position_taken?(board, index) && index.between?(0,8))
    true
  else
    false
  end
end

# Check how many positions are filled to determine what the turn count is
def turn_count(board)
  counter = 0
  board.each do |position|
    if position != " "
      counter += 1
    end
  end
  counter
end

# Determine which player is playing based on turn count
def current_player(board)
  if turn_count(board).to_i.even?
    current_player = "X"
  else
    current_player = "O"
  end
end

# Add current player to chosen position
def move(board, index, character)
  board[index] = character
end

# Ask user where they'd like to go next and move there if valid
# Otherwise, ask again
def turn(board)
  puts "Please enter 1-9:"

  index = input_to_index(gets.strip)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Check if anyone has won the board
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

# Check if the board is full
def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

# Check if board is full and no one has won
def draw?(board)
  !won?(board) && full?(board)
end

# Check if game is over (won or full (draw))
def over?(board)
  won?(board) || full?(board)
end

# Determine which player won
def winner(board)
  if win_combo = won?(board)
    test_position = win_combo[0]
    board[test_position]
  end
end

# Play the game
def play(board)
  while !over(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
