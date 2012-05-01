##
# Supporting code can be found at https://github.com/edda/codejam
##

class PasswordProblem < Solver
  
  def initialize(input_filename)
    f = File.new(input_filename)
    @test_case_count = f.gets.strip.to_i
    @test_cases = []
    @test_case_count.times do |i|
      test_case = []
      test_case << f.gets.strip.split(' ') # already typed chars and total chars
      prob = f.gets.strip.split(' ') # probability for correctness of already typed chars
      test_case << prob.collect { |x| x.to_f} # convert to float

      @test_cases << test_case
    end
  end
  
  def solve
   @test_case_count.times do |case_i|
      test_case = @test_cases[case_i]
      chars_typed = test_case[0][0].to_i
      total_chars = test_case[0][1].to_i
      remainder = total_chars - chars_typed
      probabilities = test_case[1]
      
      # stroke counts
      stroke_count_keep_going = remainder + 1
      stroke_count_repeat = total_chars + 1 
      stroke_count_enter_immediately = total_chars + 2
      
      # calculate expected keystrokes
      p_all_correct = probabilities.inject(:*)
      keep_going_expected = p_all_correct * stroke_count_keep_going + (1 - p_all_correct) * (stroke_count_keep_going + stroke_count_repeat)
      enter_immediately_expected = stroke_count_enter_immediately
      
      @expectations = [keep_going_expected, enter_immediately_expected]
      calculate_back_i_expected(probabilities, total_chars, chars_typed, remainder)
      
      # make sure to display result with a precision of 6 digits (pad with 0s if necessary)
      print("%.6f" % @expectations.min.round(6), case_i + 1)
    end
    
  end
  
  def stroke_count_back_i(remainder, i)
    i*2 + remainder + 1
  end
  
  def calculate_back_i_expected(probabilities, total, chars_typed, remainder)
    prob_success = 1
    # reuse previous probability calculation. Start with prob of 1 for the case where we backspace all typed chars
    # the probability that we get the correct password on first try will get smaller and smaller as we progress to fewer backspaces
    chars_typed.times do |i|
      stroke_back_i = stroke_count_back_i(remainder, chars_typed - i)
      @expectations << prob_success * stroke_back_i + (1 - prob_success) * (stroke_back_i + total + 1)
      # add probability for next char to have been typed correctly
      prob_success *= probabilities[i]
    end
  end
  
  def print(result, i)
    puts "Case ##{i}: #{result}"
  end
  
end