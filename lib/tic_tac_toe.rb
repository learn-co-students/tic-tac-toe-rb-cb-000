# Define winner variable
$who_won

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Center column
  [2,5,8], # Right column
  [0,4,8], # First diagonal
  [2,4,6]  # Last diagonal
  ]

  def display_board(array)
    puts " #{array[0]} | #{array[1]} | #{array[2]} "
    puts "-----------"
    puts " #{array[3]} | #{array[4]} | #{array[5]} "
    puts "-----------"
    puts " #{array[6]} | #{array[7]} | #{array[8]} "
  end


  def input_to_index(user_input)
    user_input.to_i - 1
  end


  def move(array, index, character)
    array[index] = character
  end


  def position_taken?(board_name, index)
    !(board_name[index].nil? || board_name[index] == " ")
  end


  def valid_move?(same_array, same_position)
    if position_taken?(same_array, same_position) == false && same_position.between?(0, 8)
      return true

    else
      return false
    end
  end

  def turn(board_name)
    puts "Please enter 1-9:"
    input = gets.strip
    newinput = input_to_index(input)

    if valid_move?(board_name, newinput) == true
      move(board_name, newinput, current_player(board_name))
      puts display_board(board_name)


    else
      turn(board_name)
    end
  end

  def turn_count(board_name)
    counter = 0

    board_name.each do |position|

      if position == nil || position == " " || position == ""

      else
        counter += 1
      end
    end

    return counter
  end


  def current_player(board_name)

    if turn_count(board_name).even? == true
      return "X"
    else
      return "O"
    end
  end

  def x_won?(board_name)
    WIN_COMBINATIONS.detect do |combo_array|
        combo_array.all? do |combo_index|
          position_taken?(board_name, combo_index) == true && board_name[combo_index] == "X"
        end
      end
  end

  def o_won?(board_name)
    WIN_COMBINATIONS.detect do |combo_array|
        combo_array.all? do |combo_index|
          position_taken?(board_name, combo_index) == true && board_name[combo_index] == "O"
        end
      end
  end

  def won?(board_name)

    if x_won?(board_name) != nil
      $who_won = "X"
      puts "Congratulations X!"
      x_won?(board_name)

    elsif o_won?(board_name) != nil
      $who_won = "O"
      puts "Congratulations O!"
      o_won?(board_name)

    else
      $who_won = nil
      return false
    end
  end

  def full?(board_name)
  #return true if every board element is filled

    WIN_COMBINATIONS.all? do |combo_array|
      combo_array.all? do |combo_index|
        position_taken?(board_name, combo_index) == true
        end
      end
  end

  def draw? (board_name)

    if won?(board_name) != false
      return false
    else
      puts "Cats Game!"
      full?(board_name)

    end
  end


  def over?(board_name)

    if won?(board_name) != false || draw?(board_name) == true || full?(board_name) == true
      return true
    else
      return false
    end
  end

  def winner(board_name)

    won?(board_name)
    $who_won

  end


  def play(board_name)
    # the below works per
    # https://stackoverflow.com/questions/6418017/what-is-recursion-and-how-does-it-work
    # need to study this more.  Don't QUITE understand.

    return if over?(board_name) == true
    turn(board_name)
    play(board_name)



  end
