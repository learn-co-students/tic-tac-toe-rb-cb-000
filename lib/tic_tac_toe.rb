# Helper Methods
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
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end



def turn_count(board)
  turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    taken = combo.all? do |pos|
      position_taken?(board,pos)
    end
    if (board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]] && taken)
      return combo
        end
  end
  return false
end

def full?(board)
 return !board.include?(" ")
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  return won?(board) || draw?(board) || full?(board)
end

def winner(board)
  win_pos = won?(board)
  if (win_pos)
    return board[win_pos[0]]
  else
    return nil
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
    if(won?(board))
      if winner(board) == "X"
        puts "Congratulations X!"
      else
        puts "Congratulations O!"
      end
    elsif(draw?(board))
      puts "Cats Game!"
      end
  end
  if(won?(board))
    if winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  elsif(draw?(board))
    puts "Cats Game!"
    end
end

test = ["X","X","X"," "," "," "," "," "," "]
play(test)
