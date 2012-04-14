##
# Supporting code can be found at https://github.com/edda/codejam
##

class DancingWithGooglers < Solver

  def initialize(input_filename)
    super (input_filename)
    determine_permutations
  end
  
  def parse
    test_case_count = @input.shift.to_i
    parsed_lines = []
    @input.each do |line|
      parsed_lines << line.strip.split(' ')
    end
    [parsed_lines, test_case_count]
  end
  
  def solve
    # parse input
    test_cases, test_cases_count = parse
    
    # solve test cases
    1.upto(test_cases_count) do |i|
      result = determine_max_dancers(test_cases[i-1])
      print(result, i)
    end
  end
  
  def determine_max_dancers(test_case)
    result = 0
    # test_case contains at index:
    # 0 : number of dancers
    # 1 : number of surprising score triplets
    # 2 : p = best score a dancer needs to have reached at minimum to be counted towards the result
    # next: (number of dancers) total scores
    dancers, surprises, best_score = test_case.shift(3)
    normal_best_scores_reached = 0
    surprise_best_scores_reached = 0
    test_case.each do |total_score|
      # increase normal score count if the last item of the triplet (the largest number) is >= best_score
      if @normal_triplets.fetch(total_score.to_i, [-1,-1,-1])[2] >= best_score.to_i
        normal_best_scores_reached += 1
      elsif @surprising_triplets.fetch(total_score.to_i, [-1,-1,-1])[2] >= best_score.to_i
        surprise_best_scores_reached += 1
      end
    end
    # determine max number of people with best score reached
    result = normal_best_scores_reached + [surprise_best_scores_reached, surprises.to_i].min
  end
  
  def determine_permutations
    @normal_triplets = {}
    @surprising_triplets = {}
    (2..28).each do |score|
      result = score / 3
      case (score % 3)
      when 0
        @normal_triplets[score] = [result, result, result]
        @surprising_triplets[score] = [result - 1, result, result + 1] 
      when 1
        @normal_triplets[score] = [result, result, result + 1]
        @surprising_triplets[score] = [result - 1, result + 1, result + 1]
      when 2
        @normal_triplets[score] = [result, result + 1, result + 1]
        @surprising_triplets[score] = [result, result, result + 2]
      end
    end
    @normal_triplets[0] = [0,0,0]
    @normal_triplets[1] = [0,0,1]
    @normal_triplets[29] = [9,10,10]
    @normal_triplets[30] = [10,10,10]
  end
  
end