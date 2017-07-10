WIN_COMBINATIONS = [
  # top row
  [0,1,2],
  # middle row
  [3,4,5],
  # bottom row
  [6,7,8],
  # left column
  [0,3,6],
  # middle columm
  [1,4,7],
  # right column
  [2,5,8],
  # diagonal left top to right bottom
  [0,4,8],
  # diagonal right top to left bottom
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

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else
    true
  end
end

def valid_move?(board, position)
  if !position_taken?(board, position) && position.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  position = input_to_index(input)

  if valid_move?(board, position)
    # if move is valid, add player symbol to board array at position
    # reminder: use value of "X" or "O" that is returned from current_player method, instead of a default value for player
    move(board, position, current_player(board))

    display_board(board) # display board with player move
  else
    turn(board) # if move isn't valid, ask again for player move
  end
end

def turn_count(board)
  # 1. start with 0 plays
  plays_made = 0

  # 2. for each position in board array
  board.each do |play_position|
    # 3. if position isn't empty, add 1 to the plays count
    if play_position != " "
      plays_made += 1
    end
  end
  # 4. return total number of plays
  return plays_made
end

def current_player(board)
  # 5. if turn_count returns an even number, it is "X" turn. If it returns an odd number, it is "O" turn.
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    # get the winning position index from each win_combo, see if positions are filled & if position values match
    if position_taken?(board, win_combo[0]) && board[ win_combo[0] ] == board[ win_combo[1] ] && board[ win_combo[1] ] == board[ win_combo[2] ]
      return win_combo
    else
      false
    end
  end
end

def full?(board)
  # returns true if all board positions have a value
  board.all? do |position|
    position != " "
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true # returns true if the board has not been won & the board is full
  else
    false # returns false if board is not full & board is not won / returns false if board is won
  end
end

def over?(board)
  # returns true if the board is won, if there is a draw, or if the board is full
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board) # if the board is won
    board[won?(board)[0]] # return the symbol that is at the first (and each) position of the win_combo [#,#,#]
    # puts board[won?(board)[0]]
  end
end
