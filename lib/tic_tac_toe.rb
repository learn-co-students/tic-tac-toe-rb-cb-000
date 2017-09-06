# Helper Methods
WIN_COMBINATIONS = [
[0,1,2], # Top row
[3,4,5], # Middle row
[6,7,8], # Bottom row
[0,3,6], # Left column
[1,4,7], # Middle column
[2,5,8], # Right column
[0,4,8], # Left to right vertical
[2,4,6], # Right to left vertical
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  index.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.to_i.between?(0, 8) && !position_taken?(board, index.to_i)
end

def turn(board)
        puts "Please enter 1-9:"
        index = gets.strip
        index = input_to_index(index)
       if valid_move?(board,index)
       move(board, index, current_player(board))
       display_board(board)
       else
       turn(board)
       end
end

def turn_count(board)
  counter = 0
  board.each do |board_location|
    if board_location == "X" || board_location == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
  	return "X"
  else turn_count(board).odd?
  	return "O"
end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_comb|
    if (win_comb.any? {|position| position_taken?(board, position)}) && (board[win_comb[0]] == board[win_comb[1]] && board[win_comb[0]] == board[win_comb[2]])
      win_comb
    end
  end
end

def full?(board)
  board.none? do |position|
    position == " "
  end
end

def draw?(board)
  full?(board) && !(won?(board))
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
    puts "You've won the game!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end













