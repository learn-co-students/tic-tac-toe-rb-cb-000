def position_taken?(board, index)
  if board[index] == " "
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end


def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  if valid_move?(board, index)
    player_token = current_player(board)
    position_taken?(board, index)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board) == true
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    else
      turn(board)
    end
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
