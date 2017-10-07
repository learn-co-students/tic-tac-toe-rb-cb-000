
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |array|
    pos1 = board[array[0]]
    pos2 = board[array[1]]
    pos3 = board[array[2]]
    if pos1 == pos2 && pos1 == pos3 && pos1 != " " && pos1 != ""
      return array
    end
  end
  return false
end

def full?(board)
  counter = 0
  board.each do |take|
    if !position_taken?(board, counter)
      return false
    end
    counter += 1
  end
  return true
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board)
    return true
  elsif won?(board)
    return true
  else
    false
  end
end

WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
]

def winner(board)
  if won?(board)
    WIN_COMBINATIONS.each do |array|
      pos1 = board[array[0]]
      pos2 = board[array[1]]
      pos3 = board[array[2]]
      if pos1 == pos2 && pos1 == pos3 && pos1 != " " && pos1 != ""
        return pos1
      end
    end
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " "
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn = turn_count(board)
  if turn % 2 == 0
    return "X"
  else
    return "O"
  end
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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

def play(board)
  counter = 1
  while counter <= 9
    turn(board)
    counter += 1
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  winner = winner(board)
  if won?(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
