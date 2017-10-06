
board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

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

def won?(array)
  WIN_COMBINATIONS.detect do | check |

    win_index_1 = check[0]
    win_index_2 = check[1]
    win_index_3 = check[2]

    position_1 = array[win_index_1]
    position_2 = array[win_index_2]
    position_3 = array[win_index_3]

if position_taken?(array, win_index_1) && position_taken?(array, win_index_2) && position_taken?(array, win_index_3)

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return check
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return check
    elsif array[WIN_COMBINATIONS[6][0]] == "X" && array[WIN_COMBINATIONS[6][1]] == "X" && array[WIN_COMBINATIONS[6][2]] == "X"
      return [0,4,8]
    elsif array[WIN_COMBINATIONS[6][0]] == "O" && array[WIN_COMBINATIONS[6][1]] == "O" && array[WIN_COMBINATIONS[6][2]] == "O"
      return [0,4,8]
    elsif array[WIN_COMBINATIONS[7][0]] == "X" && array[WIN_COMBINATIONS[7][1]] == "X" && array[WIN_COMBINATIONS[7][2]] == "X"
      return [2,4,6]
    elsif array[WIN_COMBINATIONS[7][0]] == "O" && array[WIN_COMBINATIONS[7][1]] == "O" && array[WIN_COMBINATIONS[7][2]] == "O"
      return [2,4,6]
    else
      return false
  end
end
end
end


def full?(array)
  array.all?{|filled| filled == "X" || filled == "O"}
end


def draw?(array)
  if !won?(array) && full?(array)
    puts "Cat's Game!"
    return true
  end
end


def over?(array)
  if won?(array) || draw?(array) || full?(array)
    true
  else
    false
  end
end

def winner(array)
  wincombo = won?(array)
  if wincombo === nil
    return nil
  elsif array[wincombo[0]] == "X"
    return "X"
  elsif array[wincombo[0]] == "O"
    return "O"
  end
end

def turn_count(array)
counter = 0

array.each do | count |
  if count == "X" || count == "O"
    counter += 1
end
end
counter
end


def current_player(array)
  x = turn_count(array) % 2 == 0
if x == true
  "X"
elsif x == false
  "O"
end
end

def valid_move?(board, index)
if index.between?(0,8) && !position_taken?(board, index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"

  user_input = gets.strip

  index = input_to_index(user_input)
  token = current_player(board)


  if valid_move?(board,index)
    puts 'valid move'
    move(board, index, token)
    display_board(board)
   else
    puts 'try again'
    turn(board)
  end
  display_board(board)
end

def input_to_index(user_input)
    "#{user_input}".chomp.to_i - 1
end


def move(array, position, char)
  array[position] = char
end



def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def play(array)
  while over?(array) == false
    turn(array)
  end
  if won?(array).class == Array
    puts "Congratulations #{winner(array)}!"
  elsif draw?(array) === true
    puts "Cats Game!"
  end
  draw?(array)
end
