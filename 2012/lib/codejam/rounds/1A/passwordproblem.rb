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
    # puts "TEST CASES: #{@test_cases.inspect}"
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
      p_all_correct = p_entry_correct(probabilities)
      # puts "Probabilities: #{probabilities.inspect}"
      # puts "p_all_correct = #{p_all_correct}"
      keep_going_expected = p_all_correct * stroke_count_keep_going + (1 - p_all_correct) * (stroke_count_keep_going + stroke_count_repeat)
      enter_immediately_expected = stroke_count_enter_immediately
      
      expectations = [keep_going_expected, enter_immediately_expected]
      if (chars_typed > 0)
        (1..chars_typed).each do |i|
          expectations << back_i_expected(probabilities, p_all_correct, total_chars, remainder, i)
        end
      end
      
      # puts "Expectations: #{expectations.inspect}"
      
      print("%.6f" % expectations.min.round(6), case_i + 1)
    end
    
  end
  
  def stroke_count_back_i(remainder, i)
    i*2 + remainder + 1
  end
  
  def back_i_expected(probabilities, p_all_correct, total, remainder, i)
    stroke_back_i = stroke_count_back_i(remainder, i)
    p_error_last_i = p_error_only_in_last_i_chars(probabilities, i)
    p_repeat_needed = 1 - p_all_correct - p_error_last_i
    
    p_all_correct * stroke_back_i + p_error_last_i * stroke_back_i + p_repeat_needed * (stroke_back_i + total + 1)
  end
  
  def p_entry_correct(probabilities)
    probabilities.inject(:*)
  end
  
  def p_error_only_in_last_i_chars(probabilities, i)
    p_no_error_before_last_i_chars = probabilities[0..probabilities.length-i-1].inject(:*)
    p_at_least_1_error = p_at_least_1_error_in_last_i_chars(probabilities, i)
    
    # puts "Back #{i} --- No Error before last #{i}: #{p_no_error_before_last_i_chars}"
    # puts "Back #{i} --- Error in last #{i}: #{p_at_least_1_error}"
    
    p_no_error_before_last_i_chars * p_at_least_1_error
  end
  
  def p_at_least_1_error_in_last_i_chars(probabilities, i)
    p_no_error_in_last_i = probabilities[probabilities.length - i..probabilities.length - 1].inject(:*)
    # puts "No error in last i. i = #{i} -- p = #{p_no_error_in_last_i}"
    (1 - p_no_error_in_last_i)
  end
  
  def print(result, i)
    puts "Case ##{i}: #{result}"
  end
  
end