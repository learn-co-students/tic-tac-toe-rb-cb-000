# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won? (board)
  WIN_COMBINATIONS.each { |win_combo|
    if (position_taken?(board, win_combo[0]) &&
        board[win_combo[0]] == board[win_combo[1]] &&
        board[win_combo[0]] == board[win_combo[2]])
      return win_combo
    end
  }
  return nil
end

def full?(board)
  return !(board.include?("") || board.include?(" ") || board.include?(nil))
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  return won?(board) || draw?(board)
end

def winner(board)
  winning_indices = won?(board)
  return (winning_indices == nil) ? nil : board[winning_indices[0]]
end

def turn_count(board)
  return board.count { |char| char == "X" || char == "O" }
end

def current_player(board)
  return (turn_count(board) % 2 == 0) ? "X" : "O"
end

def display_board(board)
  row_separator = "-----------"
  row_index = 0
  while row_index < 3
    if (row_index > 0)
      puts row_separator
    end
    display_row(board[(row_index * 3), 3])
    row_index += 1
  end
end

def display_row(row)
  cell_index = 0
  while cell_index < 3
    if (cell_index > 0)
      print "|"
    end
    print (" #{row[cell_index]} ")
    cell_index += 1
  end
  print "\n"
end

def input_to_index(player_input)
  return player_input.to_i - 1
end

def move(board, position, char)
  board[position] = char
end

def valid_move?(board, index_to_validate)
  if (index_to_validate.between?(0, board.size - 1) && !position_taken?(board, index_to_validate))
     return true
   else
     return false
   end
end

def turn(board)
  puts ("Please enter 1-9:")
  input = gets.chomp
  index = input_to_index(input)
  if (valid_move?(board, index))
    move(board, index, current_player(board))
    display_board(board)
  else
    puts("Sorry, #{input} is not valid!")
    turn(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  # rows
  [0,1,2],
  [3,4,5],
  [6,7,8],
  # columns
  [0,3,6],
  [1,4,7],
  [2,5,8],
  # diagonals
  [0,4,8],
  [2,4,6]
]
