WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

#SetUp-------------------
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
 index = user_input.to_i
 index -= 1
end

def move(board, index, token)
  board[index] = token
  turn_count(board)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
      user_input = gets.strip
      index = input_to_index(user_input)
          if valid_move?(board, index)
            move(board, index, current_player(board))
          else
            turn(board)
          end
      display_board(board)
end


def turn_count (board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end


def won?(board)
WIN_COMBINATIONS.find do |spot|
  board[spot[0]] == board[spot[1]] && board[spot[0]] == board[spot[2]] && position_taken?(board, spot[0])
  end
end

def full?(board)
  board.none? do |i|
  i == " "
  end
end

def draw?(board)
  won?(board) == nil && full?(board) == true
end

def over?(board)
  won?(board) != nil || full?(board) == true || draw?(board) == true
end

def winner(board)
  if won?(board) != nil
    winner = board[won?(board)[0]]

  end
end


def play(board)
      until over?(board) == true
      turn(board)
      end
        if draw?(board) == true
          puts "Cat\'s Game!"
        elsif won?(board)
          puts "Congratulations #{winner(board)}!"
        end
end
