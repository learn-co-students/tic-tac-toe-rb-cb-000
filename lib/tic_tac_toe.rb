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

board = [" ", " ", " "," "," "," "," "," "," "]

def display_board board
  # board = [" "," "," "," "," "," "," "," "," "]
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(int)
   int.to_i - 1
end

def move (board, position, player_token)
  board[position] = player_token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move? board, index
  if position_taken? board, index
    return false
  elsif index > 8 || index < 0
    return false
  else
    return true
  end
end

def turn_count board
  my_turns = 0
  board.each do |i|
    if i == "X" || i == "O"
      my_turns += 1
    end
  end
  return my_turns
end

def current_player board
  if((turn_count board) % 2) === 1
    return "O"
  else
    return "X"
  end
end

def turn(board)
  over? board
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  if valid_move?(board, input)
    move(board, input, (current_player board))
    display_board(board)
  else
    puts "That is an invalid move."
    turn(board)
  end
end


def won? board
  WIN_COMBINATIONS.each do |arr|
    if(board[arr[0]] == "X" && board[arr[1]] == "X" && board[arr[2]] == "X") || (board[arr[0]] == "O" && board[arr[1]] == "O" && board[arr[2]] == "O")
      return arr
    end
  end
  return false
end

def full? board
  if !(won? board) && board.none?{|i|  i == " "}
    return true
  else
    return false
  end
end

def draw? board
  if !(won? board) && (full? board)
    return true
  else
    return false
  end
end

def over? board
  if(won? board)
    return true
  elsif(draw? board)
    return true
  elsif(full? board)
    return true
  end
end

def winner board
  if (won? board)
    return board[(won? board)[0]]
  else
    return nil
  end
end

def play(board)
  while !(over? board) do
    turn board
  end
  if won? board
    puts "Congratulations #{winner board}!"
  elsif draw? board
    puts "Cats Game!"
  end
end
