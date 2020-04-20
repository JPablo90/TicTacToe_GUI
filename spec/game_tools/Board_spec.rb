RSpec.describe Board::Board do
	BOARD_SIZE = 3
	board = Board::Board.new(BOARD_SIZE)

	describe "#addValue" do
		it "The cell number no exists" do
			expect(false).to eq(board.addValue(25,0))
			expect(false).to eq(board.addValue(0,0))
		end

		it "The cell number exists" do
			expect(true).to eq(board.addValue(1,1))
		end
	end

	describe "#cellPosWrong?" do
		it "Less than the minimum allowed value" do
			expect(true).to eq(board.send(:cellPosWrong?, -1))
		end

		it "Greater than the maximum allowed value" do
			expect(true).to eq(board.send(:cellPosWrong?, 12))
		end

		it "This is an allowed value" do
			expect(false).to eq(board.send(:cellPosWrong?, 5))
		end
	end

	describe "#findCoordinateX" do
	  it "Cell number is equal to 5" do
		  expect(1).to eq(board.send(:findCoordinateX, 5))
	  end
	end

	describe "#findCoordinateY" do
	  it "Cell number is equal to 7" do
		  expect(2).to eq(board.send(:findCoordinateY, 7))
	  end
	end

	describe "#emptyCell?" do
		response = board.addValue(3,0)
		response = board.addValue(4,1)
		response = board.addValue(5,0)
		response = board.addValue(7,1)

		it "Cell is empty" do
		  expect(true).to eq(board.send(:emptyCell?, 0,1))
		end
		
		it "Cell isn,t empty" do
		  expect(false).to eq(board.send(:emptyCell?, 2,0))
	  end
	end
end
