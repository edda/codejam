# Supporting code can be found at https://github.com/edda/codejam

class EqualSum

  def initialize(filename)
    input = File.readlines(filename)

    input.shift.to_i.times do |i|
      puts "Case ##{i+1}:"
      debug "Case ##{i+1}:"
      output(solve(input.shift.chomp))
      
    end
  end

  def solve(input)
    inp = input.split(' ').map(&:to_i)
    numbers = inp.shift
    sums = {} # save possible combinations for each sum in this hash
    inp.each { |x| sums[x] = [[x]]}
    #get all combinations
    (2..numbers - 1).each do |i|
      combos = inp.combination(i).to_a
      combos.each do |combo|
        sum = combo.inject(:+)
        if sums.has_key?(sum)
          # we have a possible match. make sure the same number doesn't appear in both collections
          match = find_distinct(sums[sum], combo)
          if match
            return [match, combo]
          else
            sums[sum] << combo
          end
        else
          sums[sum] = [combo]
        end
      end
    end
    "Impossible"
  end
  
  def find_distinct(combo_collection, combo)
    # return the first collection that is distinct from combo
    combo_collection.find{ |item| item.each { |it| combo.index(it) == nil} }
  end
  
  def output(result)
    if result.kind_of?(Array)
      puts "#{result[0].join(' ')}\n#{result[1].join(' ')}"
      debug "#{result[0].join(' ')}\n#{result[1].join(' ')}"
    else
      puts result
      debug result
    end
  end

  def debug(*args)
    $stderr.puts *args
  end
end
