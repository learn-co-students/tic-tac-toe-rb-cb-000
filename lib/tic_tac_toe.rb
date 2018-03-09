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
  index = input_to_index
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def input_to_index
  puts "Please enter 1-9:"
  inp = gets.strip
  i = inp.to_i
  if (i > 0 && i <= 9)
    i - 1
  else
    input_to_index
  end
end

def move(board, index, player_token)
  board[index] = player_token
end

def valid_move?(board, index)
  !position_taken?(board, index)
end

def position_taken?(board, index)
  (board[index] == "X" || board[index] == "0")
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "0"
end

def turn_count(board)
  board.count{|cell| cell == "X" || cell == "0"}
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
  tokens = ["X", "0"]
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
  x_winner = "_"
  tokens = ["X", "0"]
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
  (!won?(board) && turn_count(board) == 9) ? true : false
end
