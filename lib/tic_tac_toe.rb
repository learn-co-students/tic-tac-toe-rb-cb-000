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

# displaying the board.
# method uses each_slice to put three elements of the board
# in one line, joined with ' | '.
# it uses the index of every slice to prevent
# printing out the '-----------' border on the bottom
def display_board(board)
  board.each_slice(3).with_index do |position, idx|
    puts " #{position.join(' | ')} "
    next if idx == 2
    puts "-----------"
  end
end

# taking raw user input and converting it to index
# for proper placement of tokens into the board array
def input_to_index(input)
  input.to_i - 1
end

# accepts the board, the index where user wants to place,
# and the token to be placed (X or O)
def move(board, index, player)
  board[index] = player
end

# returns true if an X or an O is placed at a specified index
def position_taken?(board, index)
  board[index] == 'X' || board[index] == 'O'
end

# checks if move is valid by making sure position is not taken
# and the processed index is 0 >= index <= 8
def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

# counts how many moves were made
def turn_count(board)
  board.count { |token| token == 'X' || token == 'O' }
end

# determines whose turn it is by looking at the turn count.
# if turn count is even or 0, it's X's turn. else, it's O's turn
def current_player(board)
  current_player = turn_count(board) % 2 == 0 ? 'X' : 'O'
end

# 1. ask for input, get input, convert to index.
# 2. check if move is valid. if it is, determine the current player
# and make the move. otherwise, call the turn method recursively
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

# goes through the combinations array and checks
# every element against the corresponding board position.
# returns the first winning combination it stumbles upon.
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[0]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

# checks if the board is full by making sure
# every spot has an X or an O
def full?(board)
  board.all? do |position|
    position == 'X' || position == 'O'
  end
end

# it's a draw if nobody won and the board is full
def draw?(board)
  !won?(board) && full?(board)
end

# the game is over if someone won or it's a draw
def over?(board)
  won?(board) || draw?(board)
end

# determines the winner by getting the winning combination
def winner(board)
  combo = won?(board)
  if combo # if it's a truthy value
    board[combo[0]]
  end
end

# the main method
# until the game is over, take turns
# if the game is won, congratulate the winner
# else if it's a draw, tell it was a draw
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    if winner(board) == 'X'
      puts 'Congratulations X!'
    elsif winner(board) == 'O'
      puts 'Congratulations O!'
    end
  elsif draw?(board)
    puts 'Cats Game!'
  end
end
