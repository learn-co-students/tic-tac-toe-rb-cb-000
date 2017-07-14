
# Helper Methods
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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  b = board
  WIN_COMBINATIONS.each do |i|
    return i if i.all?{|val| board[val] == 'X'} || i.all?{|val| board[val] == 'O'}
  end
  return nil
end

def full?(board)
  !board.include?(" ") && !board.include?("")
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  return nil unless won?(board)
  WIN_COMBINATIONS.each do |i|
    return "X" if i.all?{|val| board[val] == "X"}
  end
  return "O"
end

def turn_count(board)
  board.count('O') + board.count('X')
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while !over?(board)
    turn(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    end
    if draw?(board)
      puts "Cats Game!"
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end
