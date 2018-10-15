def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def input_to_index(input)
  input.to_i - 1
  end

def move(board, index, value)
  board[index] = value
  end

  def turn_count(board)
    counter = 0
    board.each do |element|
      if element == "X" || element =="O"
        counter += 1
      end
  end
  counter
  end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def play(board)
  while !over?(board)
    turn(board)
  end
    if won?(board)
       puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
end

  def current_player(board)
    turn_count(board).even? ? "X" : "O"
  end

def valid_move?(board, index)
  if (index.between?(0,8) && position_taken?(board,index) == false )
    true
  else
    false
  end
end

def full?(board)
  !board.any? {|element| element == " " || element == ""}
end

def draw?(board)
   !(won?(board)) && full?(board)
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end

    end
    return false
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  winning_side = won?(board)
  if winning_side == false
    return nil
  elsif board[winning_side[0]] == "X"
    return "X"
  elsif board[winning_side[0]] =="O"
    return "O"
    end

  end
