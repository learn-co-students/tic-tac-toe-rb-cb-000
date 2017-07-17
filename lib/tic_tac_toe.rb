
WIN_COMBINATIONS =
[
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
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  if board[index] == nil || board[index] == "" || board[index] == " "
    return false
  elsif board[index] == "X" ||  board[index] == "O"
    return true
  end
end

def turn(board)
    puts "Please enter 1-9:"
    num = gets.strip
    index = input_to_index(num)

    if valid_move?(board, index) == true
      move(board, index, current_player(board))
      display_board(board)
    else
      puts "Please enter a valid move"
      num = gets.strip
      index = input_to_index(num)
      move(board, index, current_player(board))
      display_board(board)
    end
end

def turn_count(board)
  tCount = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      tCount += 1
    end
  end
  return tCount
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  #Check for winning combos of 'X' or 'O' wins
  WIN_COMBINATIONS.each do |win_combo_arr|
    if ((board[win_combo_arr[0]] == "X") && (board[win_combo_arr[1]] == "X") && (board[win_combo_arr[2]] == "X"))
      return win_combo_arr
    elsif ((board[win_combo_arr[0]] == "O") && (board[win_combo_arr[1]] == "O") && (board[win_combo_arr[2]] == "O"))
      return win_combo_arr
    end
  end
  return false
end

def full?(board)
  board.all?{|mark| (mark =="X") || (mark == "O")}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if ((won?(board) != false) || (draw?(board) == true) || (full?(board) == true))
    return true
  else
    return false
  end
end

def winner(board)
  confirmed_win = won?(board)
  if won?(board) != false || nil
    return board[confirmed_win[0]]
  end
end

def play(board)
  until over?(board)
    current_player(board)
    turn(board)
  end
  if draw?(board)
       puts "Cats Game!"
  else won?(board)
     puts "Congratulations #{winner(board)}!"
   end
end
