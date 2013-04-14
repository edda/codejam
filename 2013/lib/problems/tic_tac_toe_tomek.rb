# Supporting code can be found at https://github.com/edda/codejam
require 'matrix'

class TicTacToeTomek

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      output(solve(input.shift(4)), i)
      input.shift #remove newline
    end
  end

  def solve(input)
    game_completed  = true
    sum    = 0

    input.map! do |row|
      chars = row.chomp.chars.map do |char|
        case char
        when 'X'
          sum += 1
          1
        when 'O'
          sum += 100
          100
        when 'T'
          sum += 10
          10
        else
          game_completed = false
          0
        end  
      end

      win = check_winner(sum)
      return win if win

      sum = 0

      chars     
    end

    gameboard = Matrix.rows(input)
    debug gameboard

    # check columns for winner
    gameboard.column_vectors.each do |column|
      win = check_winner(column.reduce(:+))
      return win if win
    end

    # check diagonals for winner
    win = check_winner(gameboard.trace)
    return win if win

    win = check_winner(gameboard[0, 3] + gameboard[1, 2] + gameboard[2, 1] + gameboard[3, 0])
    return win if win

    if game_completed
      return "Draw"
    end

    "Game has not completed"

  end

  def check_winner(sum)
    case sum
      when 4
        "X won"
      when 13
        "X won"
      when 310
        "O won"
      when 400
        "O won"
      else
        false
    end
  end

  
  def output(result, i)
    puts "Case ##{i+1}: #{result}\n"
    debug "Case ##{i+1}: #{result}\n"
    
  end

  def debug(*args)
    $stderr.puts *args
  end
end
