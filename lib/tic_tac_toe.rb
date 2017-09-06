WIN_COMBINATIONS = [

  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #right columns
  [1, 4, 7], #middle columns
  [2, 5, 8], #left columns
  [0, 4, 8], #diagonals
  [2, 4, 6] #diagonals

]
def display_board(board=[" "," "," "," "," "," "," "," "," "])

   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "

 end

 def input_to_index(user_input)

     index = user_input.to_i - 1

 end

 def move(board, index, current_player)

   board[index] = current_player

 end

 def position_taken?(board, position)

    !(board[position].nil? || board[position] == " " || board[position] == "")

 end

 def valid_move?(board, index)

   #test = index.to_i-1

   if !index.between?(0,8)
     false

   elsif !position_taken?(board, index)
     true
   else
     false
   end
 end

 def position_taken?(board, index)

   if board[index]== "" || board[index]== " " || board[index]== nil
     false
   else board[index]== "X" || board[index]== "O"
     true
   end
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
 def turn_count(board)
   count = 0
   board.each do|check|
     if check == "X" || check == "O"
       count += 1
     end
   end
   return count

 end
 def current_player(board)
   if turn_count(board) % 2 == 0
     return "X"
   else
     return "O"
   end

 end
 def won?(board)
   WIN_COMBINATIONS.each do |win_combo|
     win_index_1 = win_combo[0]
     win_index_2 = win_combo[1]
     win_index_3 = win_combo[2]

     position_1 = board[win_index_1]
     position_2 = board[win_index_2]
     position_3 = board[win_index_3]

     if position_1 == "X" && position_2 == "X" && position_3 == "X"
       return win_combo
     end
     if position_1 == "O" && position_2 == "O" && position_3 == "O"
       return win_combo
     end
   end
   return false
 end
 def full?(board)
   if board.include? (" ")
     return false
   else
     return true
   end

 end
 def draw?(board)
   if full?(board) && !won?(board)
     return true
   end
   #if !full?(board) && !won?(board)
     #return false
   #end
   if won?(board)
     return false
   end

 end
 def over?(board)
   if won?(board) || draw?(board) || full?(board)
     return true
   else
     return false
   end
 end
 def winner(board)
   if won?(board) == false
     return nil
   else
     return board[won?(board)[1]]
   end
 end

def play(board)
   until over?(board)
     turn(board)
      end

    if won?(board)
     puts "Congratulations #{(winner(board))}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  end
