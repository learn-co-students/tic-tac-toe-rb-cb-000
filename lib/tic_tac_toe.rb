def display_board(board)

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(array, index, character)
  array[index] = character

  array
end

def input_to_index(string_input)
  (string_input.to_i) - 1
end

def position_taken?(board, index)
  if (board[index] == " " || board[index] == ""  || board[index] == nil)
    false

  elsif (board[index] == "X" || board[index] == "O")
    true
  end
end

def valid_move?(board, index)
  if !index.between?(0,8) || position_taken?(board, index)
    false
  else
    true
  end
end

def turn_count(board)
  turns = 0
  board.each do |space|
    if position_taken?(board, board.index(space))
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turns = turn_count(board)

  if turns.even?
    "X"
  elsif turns.odd?
    "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if !valid_move?(board, index)
    while !valid_move?(board, index)
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
    end
  end

  current_player = current_player(board)
  move(board, index, current_player)

  puts
  display_board(board)
  puts

end


WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    win_index_1 = combination[0]
    win_index_2 = combination[1]
    win_index_3 = combination[2]
    if position_taken?(board, win_index_1) && position_taken?(board, win_index_2) && position_taken?(board, win_index_3)
      if board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3]
        return combination
      end
    end
  end
  false
end

def full?(board)
  board.each do |space|
    board.index(space)
    if !position_taken?(board,board.index(space))
      return false
    end
  end
  true
end

def draw?(board)
  if full?(board)
    if won?(board)
      return false
    else
      return true
    end
  end
  false
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    winning_set = won?(board)
    if board[winning_set[0]] == "X"
      "X"
    elsif board[winning_set[0]] == "O"
      "O"
    end
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
end
