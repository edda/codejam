require 'problems/equal_sums'

describe EqualSum do
  
  it "should solve test.in and return content of test.out" do
    
    File.open("data/equal_sums/test.out").readlines.each do |line|
      STDOUT.should_receive(:puts).with(line.strip)
    end
    
    EqualSum.new("data/equal_sums/test.in")
  end
end
