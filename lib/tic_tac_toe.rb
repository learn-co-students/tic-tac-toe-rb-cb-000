
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == ' ')
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
].freeze

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if (board[combo[0]] == 'X' && board[combo[1]] == 'X' && board[combo[2]] == 'X') || (board[combo[0]] == 'O' && board[combo[1]] == 'O' && board[combo[2]] == 'O')
      return combo
    end
  end
  false
end

def full?(board)
  (0..8).to_a.all? { |i| position_taken?(board, i) }
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
end
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  return board[won?(board)[0]] if won?(board)
  nil
end

def turn_count(board)
  turns = 0
  board.each do |space|
    turns += 1 if space == 'X' || space == 'O'
  end
  turns
end

def current_player(board)
  return 'X' if turn_count(board).even?
  'O'
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts 'Please enter 1-9:'
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below

def play(board)
  turn(board) until over?(board)

  puts "Congratulations #{winner(board)}!" if won?(board)
  puts 'Cats Game!' if draw?(board)
end
