require 'problems/tic_tac_toe_tomek'

describe TicTacToeTomek do

  it "should solve test.in and return content of test.out" do
    File.open("data/tic_tac_toe_tomek/test.out").readlines.each do |line|
      STDOUT.should_receive(:puts).with(line.strip)
    end
    
    TicTacToeTomek.new("data/tic_tac_toe_tomek/test.in")
  end
end
