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

def display_board(board)
  pipe_row_one = " #{board[0]} | #{board[1]} | #{board[2]} "
  pipe_row_two = " #{board[3]} | #{board[4]} | #{board[5]} "
  pipe_row_three = " #{board[6]} | #{board[7]} | #{board[8]} "
  line_row = "-----------"

  puts pipe_row_one
  puts line_row
  puts pipe_row_two
  puts line_row
  puts pipe_row_three
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index) ? true : false
end

def input_to_index(position)
  return position.to_i - 1
end

def move(board, position, player)
  return board[position] = player
end

def turn(board)
  next_turn = false
  until next_turn == true
    puts "Please enter 1-9:"
    answer = gets.strip
    index = input_to_index(answer)
    if valid_move?(board, index)
      token = current_player(board)
      move(board, index, token)
      display_board(board)
      next_turn = true
    else
      # Ask for input again
      puts "Opps, invalid entry, try again!"
    end
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    position == "X" || position == "O" ? counter += 1 : counter
  end
  return counter
end

def current_player(board)
  token = turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  winning_combo = []
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
      combination.each do |position|
        winning_combo << position
      end
    end
    if board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
      combination.each do |position|
        winning_combo << position
      end
    end
  end
  unless winning_combo.empty?
    return winning_combo
  end
end

def full?(board)
 !(board.include?(" ") || board.include?(""))
end

def draw?(board)
  (!won?(board) && full?(board))
end

def over?(board)
  (draw?(board) || won?(board))
end

def winner(board)
  combination = won?(board)
  if !combination.nil?
    return board[combination[0]]
  end
  combination
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
