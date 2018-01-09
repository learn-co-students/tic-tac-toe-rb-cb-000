WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-" * 11
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-" * 11
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if board[index] == ' ' || board[index] == '' || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  return false if position_taken?(board, index) || ! index.between?(0, 8)
  true
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count('O') + board.count('X')
end

def current_player(board)
  return 'X' if board.count('O') == 0 && board.count('X') == 0
  if board.count('O') >= board.count('X')
    'X'
  else
    'O'
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |wc|
    return wc if board[wc[0]] == 'X' && board[wc[1]] == 'X' && board[wc[2]] == 'X'
    return wc if board[wc[0]] == 'O' && board[wc[1]] == 'O' && board[wc[2]] == 'O'
  end
  false
end

def full?(board)
  board.each { |box| return false if box.nil? || box == '' || box == ' ' }
  true
end

def draw?(board)
  if ! won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  return true if won?(board) || full?(board) || draw?(board)
  false
end

def winner(board)
  return nil unless won?(board)
  return 'O' if board[won?(board)[0]] == 'O'
  return 'X' if board[won?(board)[0]] == 'X'
end

def play(board)
  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
