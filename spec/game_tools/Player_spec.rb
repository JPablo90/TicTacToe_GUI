RSpec.describe Player::Player do
  context "Creating Player" do
    it "When attributes are specified" do
      label = "X"
      player = Player::Player.new(label)
      expect(label).to eq(player.label)
    end
  end
end