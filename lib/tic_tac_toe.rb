

WIN_COMBINATIONS = [
                    [0,1,2],
                    [3,4,5],
                    [6,7,8],
                    [0,3,6],
                    [1,4,7],
                    [2,5,8],
                    [0,4,8],
                    [2,4,6]]


def display_board (board)

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end


def input_to_index(user_input)
  user_input.to_i - 1
end


def move(board, index, current_player = "X")
  board[index] = current_player
  display_board (board)
end


def position_taken? (board,index)

  if (board[index] == "" || board[index] == " "|| board[index] == nil)
      false
  elsif (board[index]=="X" || board[index]=="O")
      true
  end

end


def valid_move? (board,index)
    if ( !position_taken?(board,index)  && (index>=0 && index<10))
        true
    else
        false
    end
end

def turn(board,person)

  invalid = true



  while invalid
    puts "Please enter 1-9:"
    input=gets
    index=input_to_index(input)
    invalid=!valid_move?(board,index)


  end

    move(board,index,person)
end



def turn_count(board)

  counter=0
  board.each do |element|

    if (element=='X' || element=='O')
      counter+=1
      end

    end

  return counter
end



def current_player(board)

  if(turn_count(board)%2==0)
    return "X"
  else
    return "O"
  end
end


def won?(board)

  for win_combination in WIN_COMBINATIONS do

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if ((position_1 == "X" && position_2 == "X" && position_3 == "X")||(position_1 == "O" && position_2 == "O" && position_3 == "O"))

      puts "Congratulations #{board[win_index_1]}!"
      return win_combination

    end

  end

  return false

end


def full?(board)

  full=board.detect{|item| item==" "}
  if (full==nil)
    return true
  else
    return false
  end
end

def draw?(board)

  if (full?(board))
    if(won?(board)==false)
      puts "Cat's Game!"
      return true
    else
      return false
    end
  else
    return false
  end
end

def over?(board)

  if (won?(board)!=false || full?(board) || draw?(board))
    return true
  else
    return false
  end

end

def winner(board)

  string=won?(board)
  if (string!=false)
    return board[string[0]]
  else
    return nil
  end

end




def play(board)

  person="X"

  draw?(board)

  while (!over?(board))
    turn(board,person)


    if(person=="X")
      person="O"
    else
      person="X"
    end

  end

end
