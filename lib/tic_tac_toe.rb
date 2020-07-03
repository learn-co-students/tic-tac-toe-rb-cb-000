

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end



# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

# ["X", "O", "X", "O", "X", "X", "O", "X", "O"]

def won?(board)
  
    WIN_COMBINATIONS.each do |combination|
      
       same = (board[combination[0]] == board[combination[1]]) && (board[combination[1]] == board[combination[2]])
       
       win_status = position_taken?(board, combination[0]) && same

       if win_status
         return combination
       end
    end
    
    return nil
  
end

def full?(board)
  
    count = 0
  
    board.each_with_index do |pos, index|
      
      
      if (position_taken?(board, index))
          count += 1        
      end
      
      
    end

    return count == 9

end


def draw?(board)
  
  return full?(board) && !won?(board)
  
end

def over?(board)
  
  return draw?(board) || won?(board)
  
end

def winner(board)
  
  if !over?(board) || draw?(board)
    return nil
  else
    winning_index = won?(board)[0] 
    return board[winning_index]
      
  end
 
  
end  
  
  def turn_count(board)
  
    count = 0
    board.each do |position|
    
       if position != " "
          count += 1
       end
    
    end
    
    return count
  
end



def current_player(board)
  
   return turn_count(board).even? ? 'X' : 'O' 
  
end 
  
  


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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
  
  until over?(board) do
    
    turn(board)
   
  end
  
  
  
 
   
 
  if winner(board)
    
    puts "Congratulations #{winner(board)}!"    
  
  elsif draw?(board)
    
    puts "Cat's Game!"
   
  end
  
end

