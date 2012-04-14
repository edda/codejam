require "codejam"

describe SpeakingTongues do
  
  it "should solve the test.in file and return the correct translation as provided by the test.out file" do

    File.open("data/qualification/speakingtongues_test.out").readlines.each do |line|
      STDOUT.should_receive(:puts).with(line.strip)
    end
    
    SpeakingTongues.new("data/qualification/speakingtongues_test.in").solve
  end
  
end