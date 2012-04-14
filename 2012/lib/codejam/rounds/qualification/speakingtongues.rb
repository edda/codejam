##
# Supporting code can be found at https://github.com/edda/codejam
##

class SpeakingTongues < Solver
  
  CODE = {'a' => 'y', 'b' => 'h', 'c' => 'e', 'd' => 's', 'e' => 'o', 'f' => 'c', 'g' => 'v', 'h' => 'x', 
          'i' => 'd', 'j' => 'u', 'k' => 'i', 'l' => 'g', 'm' => 'l', 'n' => 'b', 'o' => 'k', 'p' => 'r', 
          'q' => 'z', 'r' => 't', 's' => 'n', 't' => 'w', 'u' => 'j', 'v' => 'p', 'w' => 'f', 'x' => 'm', 
          'y' => 'a', 'z' => 'q', ' ' => ' '}
  
  def parse
    Parser.parse(@input)
  end
  
  def solve
    # parse input
    test_cases, test_cases_count = parse
    
    # solve test cases
    1.upto(test_cases_count) do |i|
      result = translate(test_cases[i-1])
      print(result, i)
    end
  end
  
  def translate(test_case)
    result = ''
    test_case.each_char do |c|
      result << CODE[c]
    end
    result
  end
  
end
