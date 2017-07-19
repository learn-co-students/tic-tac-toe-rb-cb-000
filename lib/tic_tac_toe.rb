WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move (array, index, value)
  array[index] = value
  display_board(array)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end

def valid_move?(board, index)
  if index.between?(0,8)
    !(position_taken?(board, index))
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  if !(valid_move?(board, index))
      turn(board)
  else
    move(board, index, value)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turns|
    if turns != " " && turns != ""
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  player = turn_count(board) % 2
  player == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |index|
    win_combination = []
    index.each do |win_index|
      win_combination.push(board[win_index])
      if (win_combination == ["X","X","X"]) || (win_combination == ["O","O","O"])
        return index
      end
    end
  end
  return false
end

def full?(board)
  !(board.include?(" "))
end

def draw?(board)
  won = won?(board)
  full = full?(board)
  if !won && full
    return true
  elsif won || full
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  index = won?(board)
  if index != false
    if board[index[0]] == "X"
      return "X"
    elsif board[index[0]] == "O"
      return "O"
    end
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    value = winner(board)
    puts "Congratulations #{value}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
