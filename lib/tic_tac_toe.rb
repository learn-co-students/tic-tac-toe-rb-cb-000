WIN_COMBINATIONS =  [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board=[])
  puts " #{board[0]} " "|" " #{board[1]} " "|" " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " "|" " #{board[4]} " "|" " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " "|" " #{board[7]} " "|" " #{board[8]} "
end

def input_to_index(pos)
    position = pos.to_i
    position - 1

end


def move(board, pos, char)
    board[pos] = char
end


def position_taken?(board,index)
        if board[index] == " " || board[index] == "" || board[index] == nil
            return false
        else
            return true
        end
    end

    def valid_move?(board,index)


        if position_taken?(board, index) == false && index.between?(0,8) == true
            return true

        else
            return false

        end
    end


    def turn(board)
        puts "Please enter 1-9:"
        index = gets.strip
        index = input_to_index(index)
        while valid_move?(board,index) == false

          puts "Please enter 1-9:"
          index = gets.strip
          index = input_to_index(index)
        end

        move(board,index,current_player(board))
        display_board(board)

    end

    def turn_count(board)
      count = 0
      board.each do |space|
        if space == "X" || space == "O"
          count += 1

        end

      end
    return count
    end

    def current_player(board)
      turn = turn_count(board)
      if turn % 2 == 0
        return "X"
      else
        return "O"
      end
    end


    def won?(board)




        WIN_COMBINATIONS.each do |winArray|

            index1 = winArray[0]

            index2 = winArray[1]
            index3 = winArray[2]

            position1 = board[index1]
            position2 = board[index2]
            position3 = board[index3]


            if (position1 == "X" && position2 == "X" && position3 == "X") || (position1 == "O" && position2 == "O" && position3 == "O")

                return winArray
              else

            end




        end #end of WIN_COMBINATIONS.each
    false
    end

    def full?(board)
        emptySpace = board.include?(" ")
        nilSpace = board.include?(nil)

        !(emptySpace || nilSpace)

    end

    def draw?(board)
        if won?(board)
          return false

        else
         full?(board) && !won?(board)
       end


       end



    def over?(board)
      won?(board) || draw?(board) || full?(board)

    end

    def winner(board)

      if won?(board) != false

        winComb = won?(board)
        winner = board[winComb[0]]


    else
      nil
    end

    end

 def play(board)
   puts "Welcome to Tic Tac Toe!"
   while !over?(board)
   turn(board)

 end
 if won?(board)
 winnerIs = winner(board)
 puts "Congratulations #{winnerIs}!"
 elsif draw?(board)
   puts "Cats Game!"
 end
 end
