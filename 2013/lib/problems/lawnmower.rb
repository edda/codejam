# Supporting code can be found at https://github.com/edda/codejam

require 'matrix'

class Lawnmower

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      size = input.shift.chomp.split(' ')
      rows = size[0].to_i
      columns = size[1].to_i

      debug "Rows: #{rows}, columns: #{columns}"

      output(solve(input.shift(rows), rows, columns), i)
    end
  end

  def solve(input, rows, columns)
    input.map! do |row|
      row.chomp.split(' ').map { |char| char.to_i}
    end

    template = Matrix.rows(input)
    debug template

    max_height = 2

    lawn = Matrix.build(rows, columns) { |row, column| max_height}
    debug lawn

    (max_height-1..1).each do |height|
      template.each_with_index do |e, row, col|
        if e == height 
          temp_col = template.column(col)
          check_col = lawn.column(col)
          temp_row = template.row(row)
          check_row = lawn.row(row)

          temp.size.times do |i|
            # blearg, not done ...

          end
        end
      end
    end
  end

  def output(result, i)
    puts "Case ##{i+1}: #{result}"
    debug "Case ##{i+1}: #{result}"
  end

  def debug(*args)
    $stderr.puts *args
  end
end
