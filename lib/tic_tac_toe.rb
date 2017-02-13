def display_board(array)

  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "


end



def turn_count(board)
  counter = 0
  board.each { |x| counter += 1 if x != " " }
  counter
end

def current_player(board)

  counter = turn_count(board)
  return "X" if counter == 0
  if (counter + 1) % 2 == 0
    "O"
  else
    "X"
  end

end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]]

def won?(board)
  arrayX = []
  arrayO = []
  i = 0
  while i < board.length
    if board[i] == "X"
      arrayX << i
    elsif board[i] == "O"
      arrayO << i
    end


    i += 1
  end

  return false if board.all? {|x| x == " " }
  WIN_COMBINATIONS.each { |comb| return comb if comb.all? { |x| arrayX.include?(x) }}
  WIN_COMBINATIONS.each { |comb| return comb if comb.all? { |x| arrayO.include?(x) }}

  false

end

def full?(board)
  if board.any? {|x| x == " "}
    false
  elsif  won?(board) == false && !board.any? {|x| x == " " }
    true
  end

end

def draw?(board)
    if full?(board) == true && won?(board) == false
      true
    elsif  won?(board) == false && full?(board) == true
      true
    else
      false
    end
end

def over?(board)
    return true if full?(board)
    return true if won?(board) != false
    return true if draw?(board) == true
    false
end

def winner(board)
  return board[won?(board)[0]] if won?(board) != false
  nil

end

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



# Define your play method below

def play(board)
   until over?(board) == true
     turn(board)
    break if won?(board) != false

   end
   puts "Congratulations #{winner(board)}!" if won?(board) != false
   puts "Cats Game!" if draw?(board) == true
end

def turn(board)
      while true
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
        break if valid_move?(board, index)
      end
      move(board, index, value = current_player(board))
      display_board(board)

end
