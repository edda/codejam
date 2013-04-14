class Parser
  
  # default parser implementation for simple input files where each test case is one line
  def self.parse(lines = [])
      test_case_count = lines.shift.to_i
      lines.each do |line|
        line.strip!
      end
      [lines, test_case_count]
  end
  
end
