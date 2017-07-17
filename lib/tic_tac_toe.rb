def greeting(name)
  puts "Welcome to Tic Tac Toe!"
end

#  board = [" "," "," "," "," "," "," "," "," "]

  def display_board(board)
    puts (" #{board[0]} | #{board[1]} | #{board[2]} ")
    puts ("-----------")
    puts (" #{board[3]} | #{board[4]} | #{board[5]} ")
    puts ("-----------")
    puts (" #{board[6]} | #{board[7]} | #{board[8]} ")

  end


def input_to_index(input)
  input.to_i - 1
end


def move(array,index,value)
  array[index] = value
  array
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,ind)
 if ind.between?(0,8)
    true
  else
    false
  end

  if !position_taken?(board, ind) && ind.between?(0,8)
    true
  else
    false
  end

end

def turn(board)
  keep_looping  = true
  while keep_looping == true do
    puts "Please enter 1-9:"
    input = gets.chomp
    x = input_to_index(input)

    if valid_move?(board,x) == true
      puts "#{board[x]}"
      move(board,x, current_player(board))
      display_board(board)
      keep_looping = false
      break

    end
  end
end


def turn_count(board)
  counter = 0
   board.each do |item|
      item
      if item == "X" or item == 'O'
             counter += 1
      end


   end
    counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else turn_count(board).odd?
    return "O"
  end
end

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

def won?(board)
  tmp = nil;
  WIN_COMBINATIONS.each do |win_combination|
      if win_combination.all? {|ind| board[ind] == "X"} or win_combination.all?{|ind| board[ind] == "O"}
        tmp = win_combination
        break;
      else
        tmp = false
      end
    end
    return tmp;
end
def full?(board)
  board.all? do |element|
  if element == "X" or element == "O"
    true
  else
    false
    end
  end
end

def draw?(board)
  if full?(board) and !won?(board)
    true
  elsif
    won?(board)
    false
  else
    false
  end

end

def over?(board)
  if won?(board) or draw?(board) or full?(board)
    true
  else false
  end
end

def winner(board)
  if won?(board).is_a? Array
   return board[won?(board).first]
  else
    return nil
  end

end

def play(board)
   loop do 
     if over?(board)
        break
      else 
        turn(board)
      end
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
end