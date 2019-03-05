
WIN_COMBINATIONS =[
    [0, 1, 2],  # Top row
    [3, 4, 5],  # Middle row
    [6, 7, 8],  # Bottom
    [0, 3, 6],  # left column
    [1, 4, 7],  # Middle column
    [2, 5, 8],   # Right column
    [0, 4, 8],  #backslash
    [2, 4, 6]   #forward_slash
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end


def input_to_index(user_input)
  user_input.to_i-1
end


def move(array, index, value)
  array[index] = value
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    true
  else
    false
  end
end


def turn_count(board)
    counter = 0
    board.each do |box|
      if ["X", "O"].include?box.strip
        counter +=1
      end
    end
    counter
  end


def current_player(board)
  turn_count(board).even? ? "X" : "O"
end


def won?(board)
    WIN_COMBINATIONS.detect do |combo|
        win_index_1 = combo[0]
        win_index_2 = combo[1]
        win_index_3 = combo[2]

      if
        (board[win_index_1] == "X"  && board[win_index_2] == "X"  && board[win_index_3] == "X") ||
        (board[win_index_1] == "O"  && board[win_index_2] == "O"  && board[win_index_3] == "O")

        return board[win_index_1]
      end
    end
end


def full?(board)
  !board.detect{|i| i == " "}
end


def draw?(board)
  if
    full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end


def winner(board)
  if over?(board)
    winner = won?(board)
    # board[winner]
  end
end



def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
  end
  move(board, index, current_player(board))
  # display_board(board)
end


def play(board)
  until over?(board)
    # input = gets
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  display_board(board)
  puts "Congratulations #{winner(board)}!"

end
