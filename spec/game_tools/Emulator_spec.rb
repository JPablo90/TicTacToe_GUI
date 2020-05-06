RSpec.describe Emulator::Emulator do
  context "#define_board_size" do
    let(:emulator) {Emulator::Emulator.new}

    it "Board size is in range" do
      input_sizeboard = '3'
      allow_any_instance_of(Kernel).to receive(:gets).and_return(input_sizeboard)
      expect(emulator.send(:define_board_size)).to eq(input_sizeboard.to_i)
    end
  end

  context "#winner_is" do
    let(:emulator) {Emulator::Emulator.new}
    
    it "There is a tie" do
      emulator.send(:winner_is)
      expect {  puts "Draw." }.to output.to_stdout
    end

    it "Player1 is the winner" do
      emulator.player1.winner = true
      emulator.send(:winner_is)
      expect { puts "The winner is the Player 1." }.to output.to_stdout
    end

    it "Player2 is the winner" do
      emulator.player2.winner = true
      emulator.send(:winner_is)
      expect { puts "The winner is the Player 2." }.to output.to_stdout
    end
  end
end
