# frozen_string_literal: true

# this class handles all the game operations
class Game
  attr_accessor :turn_count

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

  def win_con(board)
    board.each do |row|
      row.each_cons(4) do |a|
        return true if a.uniq.size == 1 && a.first != '.'
      end
    end
    false
  end

  def check_diagonal(board)
    (0..board.size - 4).map do |i|
      (0..board.size - 1 - i).map { |j| board[i + j][j] }
    end.concat((1..board[0].size - 4).map do |i|
      (0..board[0].size - 1 - i).map { |j| board[j][j + i] }
    end)
  end

  def diagonal_inverse(board)
    board.map(&:reverse).transpose
  end

  def check_tie(board)
    board.flatten.all? { |element| element != '.' }
  end

  def game_over?(board)
    win_con(board) || win_con(board.transpose) ||
      win_con(check_diagonal(board)) || win_con(check_diagonal(diagonal_inverse(board)))
  end

  def game_result(board, player)
    if check_tie(board)
      "It's a tie!"
    else
      "#{player.name} Wins!"
    end
  end
end
