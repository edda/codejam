require "codejam"

describe PasswordProblem do
  
  it "should solve the test.in file and return the correct translation as provided by the test.out file" do

    File.open("data/1A/passwordproblem_test.out").readlines.each do |line|
      STDOUT.should_receive(:puts).with(line.strip)
    end
    
    PasswordProblem.new("data/1A/passwordproblem_test.in").solve
  end
  
end