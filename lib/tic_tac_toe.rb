

WIN_COMBINATIONS = [
  [0,1,2],#verticals
  [3,4,5],
  [6,7,8],
  [0,3,6],#horizontal
  [1,4,7],
  [2,5,8],
  [0,4,8], #diagonals
  [6,4,2]
]

def display_board (board )
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(input)
      input = input.to_i-1
  end

  def move(board, input, player)
    board[input] = player

  end

  def position_taken? (board, index)
     if board[index] == "X" || board[index] ==  "O"
      true
     elsif board[index] == " " || board[index] == "" || board[index] == nil
       false
     end
    end

    def valid_move?(board, index)
    if position_taken?(board, index) == false  && index.between?(0,8) == true
       true
    else false
    end
    end

    def turn(board)
      puts "Please enter 1-9:"
      input = gets.strip
   input = input_to_index(input)
      if valid_move?(board,input)
        move(board, input, current_player(board))
     else
        turn(board)
      end
      display_board(board)
     end


def turn_count(board)
counter = 0
board.each do |turn|
if  turn == "X" || turn == "O"
counter += 1
end
end
return counter
end

def current_player(board)
turn_count(board) % 2 == 0 ? "X" : "O"
end



def won? (board)
WIN_COMBINATIONS.each do |won|
if board[won[0]] == "X" && board[won[1]] == "X" && board[won[2]] == "X"
return  won
elsif board[won[0]] == "O" && board[won[1]] == "O" && board[won[2]] == "O"
return won
else
end
end
 false
end

def full? (board)
board.none?{|i| i == " " }
end


  def draw? (board)
    !won?(board) && full?(board)

  end


  def over?(board)
    draw?(board)  || won?(board) 
  end


def winner(board)
  if won?(board) == false
    return nil
 elsif board[won?(board)[0]] =="X"
  return "X"
elsif board[won?(board)[1]]=="O"
    return "O"
end
end


def play(board)
  until over?(board)
    current_player(board)
    turn(board)
  end
  if draw?(board)
       puts "Cats Game!"
  else won?(board)
     puts "Congratulations #{winner(board)}!"
   end
end
