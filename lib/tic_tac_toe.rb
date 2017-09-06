WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
  return index
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0, 8) == true && position_taken?(board, index) == false
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"

  input = gets.strip
  input = input_to_index(input)

  if valid_move?(board, input) == true
    move(board, input, current_player(board))
    display_board(board)
  else
    until valid_move?(board, input) == true
      puts "Please enter 1-9:"
      input = gets.strip
      input = input_to_index(input)
    end
    move(board, input, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  counter = 0

  board.each do |index|
    if !(index == " " || index.nil?)
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  player = turn_count(board)

  if player == 0 || player % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  combo = 0
    while combo < WIN_COMBINATIONS.length
      current_combo = WIN_COMBINATIONS[combo]

      win1 = current_combo.all? { |position| board[position] == "X" }
      win2 = current_combo.all? { |position| board[position] == "O" }

      if win1 == true || win2 == true
        return current_combo
      else
       false
      end

      combo += 1
    end
end

def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
  full?(board) && !(won?(board))
end

def over?(board)
  draw?(board) || won?(board)
end

def winner?(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  while !(over?(board))
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner?(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
