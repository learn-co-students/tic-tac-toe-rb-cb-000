
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
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8],
]

def input_to_index (input)
  index = (input.to_i) - 1
  return index
end

def move (board, index, player)
  board[index] = player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  board[index] != " "
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    puts "Invalid Move"
    turn(board)
  end
end

def turn_count (board)
  turns = []
  board.each do |x|
    if x == "X" || x == "O"
      turns << "x"
    else
      #pass
    end
  end
  return turns.count
end

def current_player (board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  if board.include?("X") == false && board.include?("O") == false
    return false
  else
    WIN_COMBINATIONS.each do |combo|
      if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
        return combo
      elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
        return combo
      end
    end
    return false
  end
end

def full?(board)
  !board.include?(" ") && !board.include?("")
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  elsif won?(board)
    return false
  end
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  else
    #pass
  end
end

def play(board)
  if !over?(board)
    turn(board)
    if won?(board)
      game_winner =  winner(board)
      puts "Congratulations #{game_winner}!"
    elsif draw?(board)
      puts "Cats Game!"
    else
      play(board)
    end
  else
    if won?(board)
      game_winner =  winner(board)
      puts "Congratulations #{game_winner}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  end
end
