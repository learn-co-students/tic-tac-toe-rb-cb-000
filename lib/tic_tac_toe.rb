def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
  turn(board)
  if won?(board)
    puts "Congratulations #{winner(board)}"
  elsif draw?(board)
    puts "Cat's game!"
  else
    play(board)
  end
end

def turn(board)
  puts "Please enter 1-9:"
  inp = gets.strip
  index = input_to_index(inp)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def input_to_index(inp)
  i = inp.to_i
  if (i > 0 && i <= 9)
    return i - 1
  else
    return -1
  end
end

def move(board, index, player_token)
  board[index] = player_token
end

def valid_move?(board, index)
  if (index < 0 || index >= 9) then
    return false
  else
    !position_taken?(board, index) ? true : false
  end
end

def position_taken?(board, index)
  (board[index] == "X" || board[index] == "O")
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|cell| cell == "X" || cell == "O"}
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [6, 4, 2],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def won?(board)
  won = false
  tokens = ["X", "O"]
  tokens.each {
    |t| ( WIN_COMBINATIONS.each { |w|
          (if (board[w[0]] == t && board[w[1]] == t && board[w[2]] == t) then
            won = true
          #else
            #puts "not won"
          end)
          }
        )
  }

  return won
end

def winner(board)
  x_winner = nil
  tokens = ["X", "O"]
  tokens.each {
    |t| ( #puts "testing #{t} as a winner"
          WIN_COMBINATIONS.each { |w|
            (if (board[w[0]] == t && board[w[1]] == t && board[w[2]] == t) then
              x_winner = t
            #else
              #puts "#{t} is not a winner"
            end)
          }
        )
  }

  return x_winner
end

def draw?(board)
  puts "turns = " + turn_count(board).to_s
  (!won?(board) && full?(board)) ? true : false
end

def full?(board)
  turn_count(board) == 9 ? true : false
end

def over?(board)
  (draw?(board) || won?(board)) ? true : false
end
