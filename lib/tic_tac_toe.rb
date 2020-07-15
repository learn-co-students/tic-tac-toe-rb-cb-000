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
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  puts "-----------"
end

def input_to_index(user_input)
  user_input.to_i-1
end

def move(board, position, player_token)
  board[position] = player_token
end

def position_taken?(board, position)
  !(board[position] == " " || board[position].nil?)
end

def valid_move?(board, position)
  !(position > 8 || position < 0) && !position_taken?(board, position)
end

def turn_count(board)
  number_turn = 0
  board.each { |position|
    if position == "X" || position == "O"
      number_turn += 1
    end
  }
  return number_turn
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    player = "X"
  else
    player = "O"
  end
  return player
end

def turn(board)
  puts "Please choose a position 1-9."
  user_input = gets.chomp
  position = input_to_index(user_input)
  if valid_move?(board, position)
    player_token = current_player(board)
    move(board, position, player_token)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each { |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  }
  false
end

def full?(board)
  board.all? {|element| element == "X" || element == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || full?(board) && won?(board) || !full?(board) && won?(board)
    return true
  else
    return false
  end
end

def winner (board)
  location = []
  location = won?(board)
  if location == false
    return nil
  elsif board[location[0]] == "X"
    return "X"
  elsif board[location[0]] == "O"
    return "O"
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
