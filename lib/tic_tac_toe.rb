require 'pry'

board = [" ", " ", " "," ", " ", " "," ", " ", " "]

WIN_COMBINATIONS = [
	[0,1,2],
	[3,4,5],
	[6,7,8],
	[0,4,8],
	[2,4,6],
	[0,3,6],
	[1,4,7],
	[2,5,8]
]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    position_taken?(board, combo[0]) && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
  end
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
    return !won?(board) && full?(board) ? true: false
end

def over?(board)
	if won?(board) 
		return true
	elsif full?(board) && won?(board)
		return true
	elsif full?(board)
  		return true
	elsif draw?(board)
 	    return true
	else
  		return false
    end
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo
    return board[winning_combo[0]]
  end
end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

display_board(board)

def move(board, input, value)
  board[input] = value
end

def input_to_index(input)
	return input.to_i - 1
end


def valid_move?(board, index)
	#if move is valid
	if position_taken?(board,index) == false && index.between?(0,8) == true
		return true
	#if move is invalid
	elsif position_taken?(board, index) == true
		return false
	elsif index.between?(0, 8) == false 
		return false
	end
end

def turn(board) 
	puts "Please enter 1-9:"
	input = gets.chomp
	index = input_to_index(input)
	if valid_move?(board, index) == true && turn_count(board).even? == true
		move(board, index, value = "X")
		puts display_board(board)
	elsif valid_move?(board, index) == true && turn_count(board).odd? == true
		move(board, index, value = "O")
		puts display_board(board)
	elsif valid_move?(board, index) == false
		puts "Please enter 1-9:"
		input = gets.chomp
	end
end
def isEven?(board)
	return turn_count(board) % 2 == 0 ? true : false
end

def isOdd?(board)
	return turn_count(board) % 2 == 1 ? true : false
end

def turn_count(board)
	turns = 0
	board.each do |turn|
		if turn == "X"
			turns += 1
		elsif turn == "O"
			turns += 1
		end
	end
	return turns
end

def current_player(board)
	return turn_count(board).even? == true ? "X" : "O"
end

def play(board)
	#  until the game is over
    #   take turns
    # end
     
    # if the game was won
    #   congratulate the winner
    # else if the game was a draw
    #   tell the players it has been a draw
    # end

    while over?(board) == false
    	turn(board)
    end

    if draw?(board)
    	puts "Cats Game!"
    elsif winner(board) == "X" 
    	puts "Congratulations X!"
    elsif winner(board) == "O"
    	puts "Congratulations O!"
    end
end
