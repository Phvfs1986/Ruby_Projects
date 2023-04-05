class Game

  def player_turn(player)
    loop do
      @p_choice = verify_input(player_input(player))
      break if @p_choice

      puts 'Invalid input!'
    end
    @p_choice.to_i
  end

  def verify_input(number)
    return number if number.match?(/^[1-7]$/)
  end

  def player_input(player)
    puts "#{player.name}, please choose a column between 1 and 7"
    gets.chomp
  end

  def check_vertical(player, board)
    flat = board.flatten
    flat.each_with_index do |v, i|
      if v == player.symbol && flat[i + 7] == player.symbol && flat[i + 14] == player.symbol && flat[i + 21] == player.symbol 
        puts "Winner is #{player.symbol}!"
        return true
      end
    end
    false
  end

  def check_horizontal(player, board)
    board.each do |v|
      flat = v.flatten
      flat.each_with_index do |v1, i1|
        if v1 == player.symbol && flat[i1 + 1] == player.symbol && flat[i1 + 2] == player.symbol && flat[i1 + 3] == player.symbol
          puts "Winner is #{player.symbol}!"
          return true
        end
      end
    end
    false
  end

  def check_diagonal(player, board, last_piece_played)
    row = last_piece_played[0]
    column = last_piece_played[1]
    if board[row][column] == player.symbol && board[row - 1][column + 1] == player.symbol && board[row - 2][column + 2] == player.symbol && board[row - 3][column + 3] == player.symbol
      puts "Winner is #{player.symbol}!"
      return true
    elsif board[row][column] == player.symbol && board[row + 1][column - 1] == player.symbol && board[row + 2][column - 2] == player.symbol && board[row + 3][column - 3] == player.symbol
      puts "Winner is #{player.symbol}!"
      return true
    elsif board[row][column] == player.symbol && board[row + 1][column + 1] == player.symbol && board[row + 2][column + 2] == player.symbol && board[row + 3][column + 3] == player.symbol
      puts "Winner is #{player.symbol}!"
      return true
    elsif board[row][column] == player.symbol && board[row - 1][column - 1] == player.symbol && board[row - 2][column - 2] == player.symbol && board[row - 3][column - 3] == player.symbol
      puts "Winner is #{player.symbol}!"
      return true
    end
    false
  end

  def game_over?(player, board, last_piece_played)
    check_vertical(player, board)
    check_horizontal(player, board)
    check_diagonal(player, board, last_piece_played)
  end
end
