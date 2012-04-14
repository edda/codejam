require "codejam"

describe DancingWithGooglers do
  
  it "should solve the test.in file and return the correct translation as provided by the test.out file" do

    File.open("data/qualification/dancingwithgooglers_test.out").readlines.each do |line|
      STDOUT.should_receive(:puts).with(line.strip)
    end
    
    DancingWithGooglers.new("data/qualification/dancingwithgooglers_test.in").solve
  end
  
end