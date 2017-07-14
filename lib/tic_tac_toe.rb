WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Left diagonal
  [2,4,6]  # Right diagonal
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  board.each do |space|
    if turn_count(board) % 2 == 0
      return "X"
    else
      return "O"
    end
  end
end

def won?(board) #Has the game been won?
  WIN_COMBINATIONS.each do |win_combination| #iterates through each combination
    if (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || #checks for X
       (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")    #checks for O
       return win_combination #returns the win_combination indexes that won.
    end
  end
   return false
end

def full?(board) #Is the board full?
    if board.include?(" ") #Does the board include blank spaces?
      return false
    end
      return true
end

def draw?(board) #Is the game a draw?
    if (full?(board) == false && won?(board) == false) || won?(board) != false
      #Is the board full (NO) and has the game been won (NO)?  -OR- Has the game been won? NO
      return false
    end
    return true
end

def over?(board) #Is the game over?
    if full?(board) != false && (won?(board) != false || draw?(board) != false)
      return true
    else
      return false
    end
end

def winner(board) #Who is the winner?
    if won?(board) != false #Because TRUE "won?(board)" returns win_combination.
      return board[won?(board)[0]] #Will return either X or O depending on who won.
    end
    return nil
end

def play(board)
  while over?(board) != true && won?(board) == false && draw?(board) != true
    turn(board)
#   while over?(board) != true && won?(board) == false && draw?(board) != true
#     turn(board)
#   while over?(board) != true && won?(board) == false && draw?(board) != true
# end
# end
end
# if over?(board) == true && won?(board) != false #&& draw?(board) != true

  if winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board)}!"
  else
    if draw?(board)
      puts "Cats Game!"
    end
  end
end
