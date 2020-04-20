RSpec.describe TicTacToeGUI::TicTacToeGUI do
  game = TicTacToeGUI::TicTacToeGUI.new

  it "has a version number" do
    expect(TicTacToeGUI::VERSION).not_to be nil
  end
end