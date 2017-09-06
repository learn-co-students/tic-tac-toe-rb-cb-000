require 'pry'
WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], # horizontal rows
  [0,3,6], [1,4,7], [2,5,8], # vertical rows
  [0,4,8], [2,4,6]           # diagonol rows
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, ind)
  return true if board[ind] == "X" || board[ind] == "O"
  false
end

def valid_move?(board, ind)
  on_board = ind.between?(0,8)
  on_board && !position_taken?(board, ind)
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, ind, token)
  board[ind] = token
end

def turn(board)
  token = current_player(board)
  puts "Please choose a number between 1 and 9"
  loop do
    choice = gets
    ind = input_to_index(choice)
    if valid_move?(board, ind)
      move(board, ind, token)
      break
    else
      puts "That is an invalid move. Please enter a number 1-9."
    end
  end
end

def turn_count(board)
  times = 0
  board.each { |pos| times += 1 if pos == "X" || pos == "O" }
  times
end

def current_player(board)
  times = turn_count(board)
  times.odd? ? "O" : "X"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if board[win_combo[0]] == "X" &&
       board[win_combo[1]] == "X" &&
       board[win_combo[2]] == "X"
         return win_combo
    elsif board[win_combo[0]] == "O" &&
          board[win_combo[1]] == "O" &&
          board[win_combo[2]] == "O"
            return win_combo
    end
  end
  false
end

def full?(board)
  board.all? { |pos| pos == "X" || pos == "O" }
end

def draw?(board)
  return true if !won?(board) && full?(board)
  false
end

def over?(board)
  return true if won?(board) || full?(board) || draw?(board)
  false
end

def winner(board)
  winning_combo = won?(board)
  return nil if winning_combo == false
  board[winning_combo[0]]
end

def play(board)
  until over?(board)
    turn(board)
  end

  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
