def play(board)
  until over?(board) do
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end


# turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)

  else
    puts "That's not a valid move."
    turn(board)
  end

end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  (!position_taken?(board, index) && index.between?(0, 8)) ? true : false
end

def position_taken?(board, index)
  (board[index] == " " || board[index] == "" || board[index] == nil) ? false : true
end

def move(board, index, token)
  board[index] = token
end

def input_to_index(input)
  index = input.to_i - 1
end

# current player
def turn_count(board)
  counter = 0
  board.each do |position|
    if (position != "" && position != " ")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end



# game status
WIN_COMBINATIONS = [
  [0, 1, 2],
  [0, 4, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [2, 4, 6],
  [3, 4, 5],
  [6, 7, 8]
]

def won?(board)
  winning_combo = []

  WIN_COMBINATIONS.each do |combo|
    if combo.all? {|spot| board[spot] == "X"}
      winning_combo = combo
    end
    if combo.all? {|spot| board[spot] == "O"}
      winning_combo = combo
    end
  end

  if winning_combo == []
    return false
  else
    return winning_combo
  end
end

def full?(board)
  board.none? do |spot|
    spot == "" || spot == " " || spot == nil
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  (full?(board) || draw?(board) || won?(board)) ? true : false
end

def winner(board)
  if won?(board) == false
    return nil
  else
    # won? returns an array if someone won, so use the first item in the
    # returned array to point to the index where you will find the winning
    # character
    return board[won?(board)[0]]
  end
end
