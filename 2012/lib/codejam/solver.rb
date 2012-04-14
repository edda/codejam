class Solver
  
  def initialize(input_filename)
    @input = File.open(input_filename).readlines
   # @output = File.new(input_filename.gsub('.in', '.out'), "r+")
  end
  
  def solve  
    raise "Implement me!"
  end
  
  def print(result, i)
    puts "Case ##{i}: #{result}"
    #@output.write(result << "\n")
  end
  
end
