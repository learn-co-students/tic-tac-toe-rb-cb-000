#Part 1 testing
WIN_COMBINATIONS = [
  [0, 1, 2], #top horiz
  [3, 4, 5], #middle horiz
  [6, 7, 8], #bottom horiz
  [0, 3, 6], #left vert
  [1, 4, 7], #middle vert
  [2, 5, 8], #right vert
  [0, 4, 8], #l-r diag
  [2, 4, 6] #r-l diag
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  int = input.to_i
  pos = int - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && position_taken?(board, index) == false
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  valid = valid_move?(board, index)
  if valid == true
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |index|
    if index == "X" || index == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn = turn_count(board)
  turn.even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |condition|
     if condition.all?{|position| position_taken?(board, position) == true}
       if (board[condition[0]] == "X" && board[condition[1]]=="X" && board[condition[2]]=="X")
         return condition
       elsif (board[condition[0]] == "O" && board[condition[1]]=="O" && board[condition[2]]=="O")
         return condition
       end
     end
  end
  false
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  end
end

def over?(board)
  if won?(board) != false || full?(board) == true
    true
  end
end

def winner(board)
  if over?(board) == true && draw?(board) != true
    player = board[won?(board)[0]]
  end
end

#Part two testing
def play(board)
  if over?(board) != true
    turn(board)
    if draw?(board) != true
      play(board)
    end
  else
    if won?(board) != false
      if winner(board) == "X"
        puts "Congratulations X!"
      else
        puts "Congratulations O!"
      end
    else
      puts "Cats Game!"
    end
  end
end
