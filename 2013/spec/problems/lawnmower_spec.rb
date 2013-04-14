require 'problems/lawnmower'

describe Lawnmower do

  it "should solve test.in and return content of test.out" do
    File.open("data/lawnmower/test.out").readlines.each do |line|
      STDOUT.should_receive(:puts).with(line.strip)
    end
    
    Lawnmower.new("data/lawnmower/test.in")
  end
end
